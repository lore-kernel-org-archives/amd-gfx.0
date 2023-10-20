Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB43C0032E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 16:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6CC910E110;
	Fri, 20 Oct 2023 16:05:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5298510E110
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 16:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OALkL9sdR6Qcq4EPAPK/f5KVAKpYPIlRTbAWm/AxBInsCBBSB+qXgEkfyYtF9tYRAsj3HvRR9IuMza9hUaU2ofZessX0Dk++DVu6m/ld0Ryk4hc5vdrYIPyUwlahJBht7B0nMbXWF253yxSGpkhGqKJGIXpmfRGDerr5Sg3vDoOPBsaaH/uZ12dntmLzAVeNce7k6o6IkRe5kMGWlQvpFDU3sDAd+s5dx9HG/yaBWgBl8bZgafl7tQjBN9gI1FiCfKKCMLdp66q1HhIzxqJeaW8PXxQ/GVFv3xZjUrujq19gmb46h+BZsuugWkAnVL8CjGdKU8BYzsMi/cBXeWHoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EDSIEFludG+kRIZt1giFCF7wnI1yZvXpSTom5m510k=;
 b=WLWoTApdaIon4yuO375pfZQ9RA9VfFKoxD9zurU4YXD99CMx14vGx3/Uwu8oICKBvL+6lfoj3sBs7BE27OairHxgCNM3L3ksm24zKD41LNQOw2XjYIv0aMtKDMun+T5fSFT7gzw9DegIkFci/eZDfP/CqxIXqQkMDOLphGjkXlwZ+w5MmZU8e0uAJpA3xL0yRWfyxcvxpps2fNyAqEPHLgA2a/1FQ2by0y+FCtQ6bc3PitBtY9gcMtosvB13YQ1cHtkUSL5MEuDJ8NSQ+LHdH4fKLG32ESG3c97dm9MfkPm8eOH6WJNtXoKLdtxmSTTA2ZPEQ4B31HQc6bShe85j8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EDSIEFludG+kRIZt1giFCF7wnI1yZvXpSTom5m510k=;
 b=xxpuMomxBBmuan0PQ4HqBdP+0DRR1n6bLQ/mrA4GZp8BKahdfVKw5gb6jnSbgYns1tCq1r4wJTDhQ/1ugdus7e4ELxCoKfT50DenH98zrE235wVklzzpdWic/6FnsQC/bLSr+3XVTZKbD6f/vGnLD2ekP0L7xUpZkMprn/Ba/Cw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 16:04:59 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::afb6:c0af:cadf:b5d2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::afb6:c0af:cadf:b5d2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 16:04:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Shi, Leslie" <Yuliang.Shi@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: reserve a fence slot while locking the BO
Thread-Topic: [PATCH] drm/amdkfd: reserve a fence slot while locking the BO
Thread-Index: AQHaA1Gbhz01f+bLTkSf2CBYSlM4QLBS15lj
Date: Fri, 20 Oct 2023 16:04:59 +0000
Message-ID: <BL1PR12MB5144DBE761B6C256906F8257F7DBA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231020123306.43978-1-christian.koenig@amd.com>
In-Reply-To: <20231020123306.43978-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-20T16:04:58.576Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA0PR12MB8646:EE_
x-ms-office365-filtering-correlation-id: 9273b7dc-601c-47ca-2057-08dbd1864f8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GWjiPJUKpDB/RBxr8Wuwb6Oyyft0tApBpnp1ISN5iR8f1DMgtGFGzqNab/AafgP7dWSqsFas8Ys9lRc/kJ7J9FE067TFHGcAtOy7tbth3Gz9qjFViyKyVRaDmMD3IA/rUq7rCYWQO4Yi7sk0macP/mql5tdU3FYJo5VVPxwONl2E8uNZc/osFUBcvHF41eipfo3/ddP/ErUL7Kv6lsT0a/f7LI6h3VwUN9Oi+RQqIp1mMhT7zoyg609hW7ae+pJOUWYc1Q0kBFX4Eq1WIZUNC9p+YckyP6CdyRvxf8aAS9vUBq+i7WyCT2V8I4i72uBwya2e6Yz2LxmzPsdK1yCqSAMNkYqLqk3UzUGG82jXMXSrOHlbmOvQ5zTG1/hh/SOIjsc7Yzdx8esYlmqGutH/JVGhmjl45+2iVfeu/F5pIL7eojsxhYLQYW2Au243eKbikgoDQWioZraHkmZIG2CmWmPqkPmPFSntTe481QzUt0RlHvCXLp8/7ma9V6QoLrK6jZcGaHmJmvT4wh9crV6+abp99eITz8w2n6Frs9FCrfshLFNb4HJmLiClr15zsNHEABtKfEwdV/Mx5YYu2aGyU2UvEvBBRQQxRUNCrCU+S9LmW5ZNqWxFxMMTRMqQzKZr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38070700009)(86362001)(33656002)(19627405001)(9686003)(55016003)(110136005)(7696005)(5660300002)(41300700001)(66946007)(66556008)(66476007)(316002)(38100700002)(66446008)(122000001)(76116006)(53546011)(6506007)(71200400001)(26005)(66574015)(4326008)(8676002)(64756008)(8936002)(52536014)(83380400001)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HqDBqQUVi7VLqRf6qZGkgFPdajRkprmGcB+1diQovyLeXXCgUZsdSoJX3f?=
 =?iso-8859-1?Q?NFzj7y+FjayEm/CCIARjme3AjXjbA1QUmJM8CKa3SmzIxbIZ4lIHm0BhA1?=
 =?iso-8859-1?Q?+BBdD3+VC5O68qPV26jYGSfXZ1vqL1WG6wD2eOuF1mIQ+sC6OGkDLIbQKn?=
 =?iso-8859-1?Q?bwK/slJmW3H9DSyXj6fEDWqky65G9TTvijPX0ikmzMaj/i58Qzb00dKkno?=
 =?iso-8859-1?Q?dqsbuE+AKUOPaRMNig5eF87tOiHx/VS2YinBykYa6lmiG0FT4HHx6ciEWP?=
 =?iso-8859-1?Q?PIRw5oFBE30QyuKXjGvPg42OGbz1vb66ao/p4kjROX2yq7e+0FYLWl5EEi?=
 =?iso-8859-1?Q?sPl1l7gD6W3A3aEvrlbs1M+4zBzbXSvndotvtCdS/v/oQfwqibkG6WU7Gg?=
 =?iso-8859-1?Q?IiA2fSvgR9ZytL5tJgSyndJR3CWoDQBBicwtSXKgySPijbsHk0m+hCrXK0?=
 =?iso-8859-1?Q?Qx5s5HuHpSaHqs2VYtb8GTcHFgzdX5qnmLwRTUOtLlKBDZ7kmusANM/xZY?=
 =?iso-8859-1?Q?Q8lwrjy4CvKCTS1lx+hCzh1rh0uboIijGdRVwabs+yNia6s4Qaa5NyYL12?=
 =?iso-8859-1?Q?fnSy+sJIV/YXukdANq5SnoqdONUxEUGpokcCRmMty9eTJRP6xtxapG8fdg?=
 =?iso-8859-1?Q?p9N/+HdT7zAvOtnaqYAYtksnn3XsqKAnOuwv1UrKCsU2u+AczGkpIjgS4z?=
 =?iso-8859-1?Q?TW+uK16zXwtXeMXbb2irBKJlCynGosgt1QZBmqEjOzVi7gjWH0KRRUXDlm?=
 =?iso-8859-1?Q?YhbusJ+bjXmfuqrXhBukvox4+JYn3qWOh0PCGb9AxQbp6kNRnwcTlkGo/Y?=
 =?iso-8859-1?Q?DB1k8ndYfVbSbe/Ncr2s/zJm4LjETAjsDNHnPCHkHnqbOUwWx+UiNO67fU?=
 =?iso-8859-1?Q?PSmJ4K1dtAMiuIs3jya22dGbBjIVA3oAqRR7UZoD01UDB/CBvltPKfpHq1?=
 =?iso-8859-1?Q?PvigCITlmfo3LhZwVhzDDLY1blMQv8THHxmaOfECB3vrlhlZTRAJm+V9/B?=
 =?iso-8859-1?Q?gzx+cYOa2KYRBp5BNzwbJFipY+rcCMfZQJ0z/yZaV0lze7hAglqRZ3hEQj?=
 =?iso-8859-1?Q?7ssTqUuYbOr0fQhbqYM4Ln3W3+J4P28wvKT70YXqd3QSsDTXx8XdiGjEhw?=
 =?iso-8859-1?Q?ZsKrSkvpA029r9Xvrz7c2IwWwvVJ5io7L+LjNp/W5MNoBpQ/MJOiCxYi2L?=
 =?iso-8859-1?Q?Fy3Mkc8UkK42hJm/nePS0t5T6s9u0yK9O52UP7wXaoS+6h5otGoqJvWviU?=
 =?iso-8859-1?Q?78EoUVDIf+LOUllgDZ9N9q5urMMQUGTtSWyIGuZeL43M8BEgRqcQ9BjklQ?=
 =?iso-8859-1?Q?sLZwqjws71Zh9ieqyAPHjyHQVmETfM/0ZVq0dilD3xnaiSf2l9owfKBnNY?=
 =?iso-8859-1?Q?rT6iQXjbzJ8zPCCJknt7tVvgNES2Noa+DHmSwUIAxn6dRhp1I/B/Qgr0AK?=
 =?iso-8859-1?Q?8/KlXYhlGNvnou/x6BZIEHgmxLl6NfYq35gbVvmEALnFpjTZG2v+rW8Dr7?=
 =?iso-8859-1?Q?kBrjswOwvilOfWsxM0EO2DxM6/C1DE/7/Izfg1ZwE+bEsNWn16HsymS3iL?=
 =?iso-8859-1?Q?20qxl5mdWSn9gE5Ks9XYC/eljC28NDZC4PegbuDWxbOB9nPzxb011ddiCP?=
 =?iso-8859-1?Q?vQdNc8T2zb+lA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144DBE761B6C256906F8257F7DBABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9273b7dc-601c-47ca-2057-08dbd1864f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 16:04:59.3088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzZld9EYm7qIQjApR0bF+1AMtthYv9uQMmHvV2HMJq/IeeAR2v39vtQXnPqiW/THajsAvsGxhE/hAPlC0kwsGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144DBE761B6C256906F8257F7DBABL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Friday, October 20, 2023 8:33 AM
To: Shi, Leslie <Yuliang.Shi@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.=
com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdkfd: reserve a fence slot while locking the BO

Looks like the KFD still needs this.

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
Fixes: 8abc1eb2987a ("drm/amdkfd: switch over to using drm_exec v3")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7d6daf8d2bfa..e036011137aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1103,7 +1103,7 @@ static int reserve_bo_and_vm(struct kgd_mem *mem,
                 if (unlikely(ret))
                         goto error;

-               ret =3D drm_exec_lock_obj(&ctx->exec, &bo->tbo.base);
+               ret =3D drm_exec_prepare_obj(&ctx->exec, &bo->tbo.base, 1);
                 drm_exec_retry_on_contention(&ctx->exec);
                 if (unlikely(ret))
                         goto error;
--
2.34.1


--_000_BL1PR12MB5144DBE761B6C256906F8257F7DBABL1PR12MB5144namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Friday, October 20, 2023 8:33 AM<br>
<b>To:</b> Shi, Leslie &lt;Yuliang.Shi@amd.com&gt;; Kuehling, Felix &lt;Fel=
ix.Kuehling@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.fr=
eedesktop.org&gt;<br>
<b>Cc:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: reserve a fence slot while locking the =
BO</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Looks like the KFD still needs this.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Fixes: 8abc1eb2987a (&quot;drm/amdkfd: switch over to using drm_exec v3&quo=
t;)<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
index 7d6daf8d2bfa..e036011137aa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
@@ -1103,7 +1103,7 @@ static int reserve_bo_and_vm(struct kgd_mem *mem,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(ret))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
error;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D drm_exec_lock_obj(&amp;ctx-&gt;exec, &amp;bo-&gt;tbo.bas=
e);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D drm_exec_prepare_obj(&amp;ctx-&gt;exec, &amp;bo-&gt;tbo.=
base, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_exec_retry_on_contention(&amp;ctx-&gt;exec);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(ret))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
error;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144DBE761B6C256906F8257F7DBABL1PR12MB5144namp_--
