Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECFAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 15:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5879510F33A;
	Fri, 28 Jan 2022 15:36:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D35BC10F33A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 15:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7OaVAXURD0wsH4QDdGCaza0at8K3NQL4L+ozLvcuwLhoBBL20McTiC4j7JPIeDTZZZdyNRxD6TqYcpDRar6FqGtbOUb/U/5ANyHbJc+D9zeVMIAMTg4IUROD9Xn7es1ymqitOSUTmgTWyrW3wGYmdoAbfTDC22RcVwpMRq8BL19k2aLd64hVX8Lvo/gQXUxdM66WB8lhAozVlYB+DLroq1jtleWA0gCrt5us5J5gCSugHdSq46Sb11qvWXRJtVlhOFhhXlJxo/ITOxbtAyaa2vl3TYg568iJDKEe4khaMIR8+NLOoXa11ztv6Rv03q5PXVTyc5tHp39vsBsG7fqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M9PMxdfo5JZIOSfqkcZtko9cQirPDLRhsSRJ+G/8FA=;
 b=G3ULwAH+FYsh3G1QE6OM/vB9l2W7PwLlClFPFrlDm3TXQd1G5lb5zEMknkyMIEOwKNybK1cUxVoExpJxkauzICRStQ2iMMiQytrldPgwL75b9Lo73S515M1pPq+Ob4HbOkugFJm4snC8sENFmzIlZSqUyhToNhr3LIRZbKkqyN/T5d7CtWd6Ol73OWDIDRdUas0Gn8k37zvML3QiF7rDiao7OVDJFr50j0iGJwEgtpif0QuqHrnAj9uaxQIXQfDKnR0NhE5S/yyEM++j/zifXIuspy05D0x3DHgnL5gT017Jm8pHdJhNW4+j6Z4bsF02ebnhcwNytm+yEK5ziu9ARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M9PMxdfo5JZIOSfqkcZtko9cQirPDLRhsSRJ+G/8FA=;
 b=1ZLGALMCy/bTXY9ocvtCjKY+Qk0AbhV03C6A7cWH2oHGKaEZ1cKcBL8Nir1RiAZf0C9mUWKQuRpaqT6fHQdjDYLAl4TfqXZfCfRM68HNLYKeHiSHQKfiOxBcldLPQh3260z5YgODT2L5CB33rQ2/un4QEdxTzp98kbdXRBOA02A=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN6PR1201MB0178.namprd12.prod.outlook.com (2603:10b6:405:55::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 15:36:42 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 15:36:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: drop flood print in rlcg reg access function
Thread-Topic: [PATCH] drm/amdgpu: drop flood print in rlcg reg access function
Thread-Index: AQHYFFqF3xid4ySHMEmTGURQbngP/qx4kOBn
Date: Fri, 28 Jan 2022 15:36:42 +0000
Message-ID: <BL1PR12MB5144D0D8F1A7585ED2C5B4A7F7229@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220128151937.25577-1-guchun.chen@amd.com>
In-Reply-To: <20220128151937.25577-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-28T15:36:42.082Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: b03bcca8-385c-b1a0-3d7a-e2355b130150
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9859a0ac-4c8d-4035-9cd6-08d9e273fc1a
x-ms-traffictypediagnostic: BN6PR1201MB0178:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0178033349D86F32E581637EF7229@BN6PR1201MB0178.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /17TO8d5MABDNm9z6GxjtUgEe5m19lQp+waSZt1p3quK1iFymxW2gusWGjPQONbrbyIPKazmPYRZhbTfNvNE9kYwUbwBtOYv2GKd4Pn/arR5wIBxhF8l+3s19JYgi+SiCXrebE5hQazbnRdrA+FG7jswfJdud79QUH+6+ugsNopN+0Ai5z2c1EvXDHEVyjRLT4LU9CLZHuUFKpa9LC4DFpdNaNhBAhsQwJjnq6gfmnPPk5KRq+5a1QsSr9Vl+Db0FhahYUnsEabqEqUg52b8fw2f+EtcUtOocwxd3AeQ4/WODnlGl3HXqHp/y44JVRR8tWOYv8LxCnzMcK77+2nrzIMl5UOMGy6J3f5EBTdIXe8Yjm0J6smfGD8M/dKcjbgb+xCaccO/lIe1f4r39Llq1WWipcUpY4JS4QBDkaDUe7ba2cVvfMYgBpdDnbnSKiN+toU0fwehXsnyBLFNqb1Z63IfY5mXsjlCMcuvFv85PnO0rwY+aexyOEUatF2GrVVLAmoT2qfg2mNpKENmTPC4yLVuvF3UHgH3q03yG6LXr/kmIcxmpfAA6eQ9rMVQZVAQKNc/+Y17yhr2sT3fCszs9IJW6Yo08BVpQZ9rdgT+mwOT7cU+9WFjEFMk2laWkGqf0yzltqeD8mhT/i+8jvYxprGG2jghA+t7cgWdzpFOUrDoXAhUobDjvyrZ0qSzrqD0+HZ75yeYsq7dgFYnvc6Fsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(8676002)(8936002)(66476007)(66446008)(55016003)(66556008)(83380400001)(38070700005)(66946007)(64756008)(86362001)(38100700002)(5660300002)(122000001)(110136005)(6636002)(7696005)(186003)(2906002)(52536014)(19627405001)(71200400001)(33656002)(316002)(53546011)(26005)(9686003)(508600001)(6506007)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fBlI1bGnUZhlmV3BvUyM7TQt+C5B9l7fz27KhL7aLIaO4mz+bdUCbQbk3BDy?=
 =?us-ascii?Q?Xe0FHW6sv7ZnbQEa7pwRwH2UatGD8MyqHHNE741vCslJoWiO3/KP+BYpEUCj?=
 =?us-ascii?Q?2P0yWh9mOrEzynMnnkdLJn2iCQz6KpT1IoKW646qV0SFWubKE2wtm3H5kJ0u?=
 =?us-ascii?Q?ppngYZJzlguqrv8VKuNo0PkrL164K7IObPeu0zRy2hqxhhUE6HgCZjDC5a2O?=
 =?us-ascii?Q?d/QtbC56iJyAzjFqKmm2E4GbRteb7Twgj3ITyNXxmdhPegoR1rrqYoAkxW5+?=
 =?us-ascii?Q?7DEO7dRSDqb0RgfqxEzE+Vqk5ubvX2AB+pBJHavgbSQy+pJlrVW5JrhgdEgi?=
 =?us-ascii?Q?Q8mz8cUKlPTJhrIJQ6b7rLsn4q6rVUHVfTGtdrx+fPvH6Di8EVAOGFD9oIaT?=
 =?us-ascii?Q?ctUV3vUJMbcKCEILhQ9/m9dkS/KmtZse60y32KWvgVBEbCvzg8xRNKwd4NK5?=
 =?us-ascii?Q?/nwgPEP3zTkp7Lph+FNG5Jzp7DecA6ivh34X6mVu4Af1HCcjaRfcO1J1VY2y?=
 =?us-ascii?Q?pBKYvONwFNikyRU7KwJLEModFqKf/JXZJ6aggvT9P8Vw/5di9EHJoZ60UiQn?=
 =?us-ascii?Q?38ZwWwNFYdALh2UL5DXgQ0zbHE0aOuREHaNxFDEDAW3aDhRfBXmnJbk3VVOe?=
 =?us-ascii?Q?gFO8wSn8D3q3x/R8Z8cpfp+QivbIHfoxWkmAL84+8VBWYTMsc03eQ/K7DBcM?=
 =?us-ascii?Q?XSGBb7PCeX4Ek3AIV+jp0CxvVwEgSk8a3qvAECV0qD50L3uQHwzPNuSi/oKm?=
 =?us-ascii?Q?iCWOygD0yoBDgj3hVzAOs87VC8mMb4ZQqXLbgxogff/WBDEAZxpqxV8+ebCH?=
 =?us-ascii?Q?EOcRvGP/AFT621y3kxpgK8RR67FuEjWeMXq2qvVrEr1kyL3zY/Mz98vXxODZ?=
 =?us-ascii?Q?ZJIEH8ca+Q9nGpAhFn1JOe6h/jmclmWv0NWSalbajWMayzdj+fLaC6/wl4P0?=
 =?us-ascii?Q?7yjQgOibs04wLQrjCLU+5YzFkpbYJA8JgtiONIsvECBKd4Z0GrgsRrFNVFku?=
 =?us-ascii?Q?MH9iyI6qu0U5Y/q6PFjFghAdhKDYBU70D80ROl1s8IaaIIe4HdxfrmseO+Sk?=
 =?us-ascii?Q?2sz/Fc07EV10gU+utbEuvsGiLXGaO8aUQFnS4oWPa2+7YyLpFLBpAcbIhk4f?=
 =?us-ascii?Q?2zN6C72E89yCNIaWAxD9nHFvMtF+oitj9Cvv8S4ZWELDwGnnI6Qpev0Vx/CN?=
 =?us-ascii?Q?i8oNT8/8GASTLzBjO5CxaT+7UWi1pqDIn4VFDnlO5mrffV6z5bpr2TV5U0+O?=
 =?us-ascii?Q?nQF7A+XEOptzolAQ3sfz+OVntLm688LtkuR82XdTmVYoTw+PkAdGpysiOb08?=
 =?us-ascii?Q?x34XgUJhBPiv1WwIA9TA+aLJgoHqvSy/5vWXFPQWdJVvJzjmfCHuvz3eLt+E?=
 =?us-ascii?Q?pYjsgaIO2PC2CEdyuv6lmOPX/MGXkdGjf+OpAeRObtkG8sGCxg1L4POBpqLm?=
 =?us-ascii?Q?91w9aMTFthq1Xqsmoak7YMxZQn4MEymDzxudwTLG5HgZQ2YYcdr4mRfNavWX?=
 =?us-ascii?Q?h0EFR2ivmOxmpzQVndXqAs1MguJdmaB7znWc6leL+GkisXKEV08H7UeN6Anx?=
 =?us-ascii?Q?FQLpPJWc7eZ6/vADaUhiiJBnRRDO0WP2tF9P1aawnY05XqRpfnyrgODussXf?=
 =?us-ascii?Q?0Jpll/IquU3asdsMxdmhaR4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144D0D8F1A7585ED2C5B4A7F7229BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9859a0ac-4c8d-4035-9cd6-08d9e273fc1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 15:36:42.7105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5eYdG/h1xAXC4Nv9Gousqe9eBYFdwsA6D5Fk5zXopClh4i0dFFFAB4UjXtPVtfOgVf+B7DwWs6zCf8apxOsDrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0178
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144D0D8F1A7585ED2C5B4A7F7229BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, January 28, 2022 10:19 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Zhang, Hawking <Hawking.Zhang@=
amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop flood print in rlcg reg access function

A lot of below message are outputed in SRIOV case.
amdgpu: indirect registers access through rlcg is not supported

Also drop redundant ret set, as it's initialized to be false already.

Fixes: d4cd09ca9bce("drm/amdgpu: add helper to query rlcg reg access flag")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 80c25176c993..b56cafb26f4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -849,9 +849,6 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct=
 amdgpu_device *adev,
                 }
                 break;
         default:
-               dev_err(adev->dev,
-                       "indirect registers access through rlcg is not supp=
orted\n");
-               ret =3D false;
                 break;
         }
         return ret;
--
2.17.1


--_000_BL1PR12MB5144D0D8F1A7585ED2C5B4A7F7229BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Friday, January 28, 2022 10:19 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;;=
 Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: drop flood print in rlcg reg access fun=
ction</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">A lot of below message are outputed in SRIOV case.=
<br>
amdgpu: indirect registers access through rlcg is not supported<br>
<br>
Also drop redundant ret set, as it's initialized to be false already.<br>
<br>
Fixes: d4cd09ca9bce(&quot;drm/amdgpu: add helper to query rlcg reg access f=
lag&quot;)<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 ---<br>
&nbsp;1 file changed, 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index 80c25176c993..b56cafb26f4a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -849,9 +849,6 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct=
 amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;indirect r=
egisters access through rlcg is not supported\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144D0D8F1A7585ED2C5B4A7F7229BL1PR12MB5144namp_--
