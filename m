Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2C4C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 02:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB800610FE
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 02:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB800610FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F30C6E9EE;
	Fri, 20 Aug 2021 02:15:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50DA6E9EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 02:15:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv6fX2naWKtM5+r2kqzCtqqnzWFA6CQW8uM5gtPzWCVzyM1Ncf40F0VgA+FOC/UkwMLJCnuoSQ/ZgLAqi2MEuoP1TTyxG/f7hm3JESAjo0vCnHL/M4PTEBVO0QL2QxqzIp2CgPJl1986zAJqJaBlkiqfFpOyZqDAagQI56RZya4BNStWfMGQRyYn1p8LbCqq7fhXegFyfMfysCxYoW9lS/Df+QNvHwdebKcNHkxX/17K1zoOISx5DMKKZ6m2yAlPy9cmWLSCF7aiIw6VFrnb4MebMxVNLbYE7VeekFaJH5L95JpTobYwSviln6S77NegRIFt3HOfHR1Ms6DN0yuRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CFFOCfR9JXrx1+XJTegx3i7JhkiaFy9g1PunOrv8f4=;
 b=VLe6VfV3M9sjnOd3KF6nL2Scg6YOdWZLfd6d8JNfTHwDloDyEvQZUWiz9R/L9IY0FToUIB+9NXBb8HTCmqkj5chEZ7ofUzBK2U3f0n+257BBe9ly7X8rPYBRAXDxm2gmN+J6sTqpuRvgdnA1ytQHv4cxbVg8Fu27fnuI2UsvgtKYePQxeB8zPKjljsqesY61KHVHOUlUJ1AQOnm1o6scZvDsBiakiWhDT/5n/XSpZF6bnudZOtojvkvh4dLVFefA2+c3MlM+914aG2WJ17NOSpefq8Z0FBLnPpLUcBf7IY6+wmcaQ2NFVCu3wqGi0qNrwjdVmFdiUPXItyeNtn1ckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CFFOCfR9JXrx1+XJTegx3i7JhkiaFy9g1PunOrv8f4=;
 b=jkP0hBqpunjCjM8XEj0EXVuAws7hOwtZbvjOh1MAuEXsJ3ans6dWb8KwPDWSL1gRf4myx00uDuaKFFgf3YqBLG0jvIS/69ZhlOcSoYcWjZss2g2vUsI4VHr4NKTF6WDHhXRIgSx7ZCeULmg3TV9Mnku+6+P1NQlee77q51GEuHg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2826.namprd12.prod.outlook.com (2603:10b6:5:76::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Fri, 20 Aug 2021 02:15:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.024; Fri, 20 Aug 2021
 02:15:22 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu, Leo"
 <Leo.Liu@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on
 suspend
Thread-Topic: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE
 on suspend
Thread-Index: AQHXlKeZ3i91IyfmtkWpwlG7kjfTZKt64RiAgAAExACAAL/JsA==
Date: Fri, 20 Aug 2021 02:15:22 +0000
Message-ID: <DM6PR12MB261971EBCF452097AA846F00E4C19@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210819030859.1470753-1-evan.quan@amd.com>
 <DM5PR12MB2517FA1095D8D016C2E784D5E4C09@DM5PR12MB2517.namprd12.prod.outlook.com>
 <BL1PR12MB5349E230CC22C6031E03DE9097C09@BL1PR12MB5349.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5349E230CC22C6031E03DE9097C09@BL1PR12MB5349.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: James.Zhu@amd.com,Leo.Liu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-20T02:15:19Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85526a67-7bd3-4338-b5fa-08d963805d62
x-ms-traffictypediagnostic: DM6PR12MB2826:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2826CA1E432EC5B9FEB99790E4C19@DM6PR12MB2826.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a9l2tIo5psru+jX7vT4zgj1lsRHS0eJNUt7GhCfwj0BhUwn4xEyEE5ReN/Dv1wtiCA8H3Lx5YnVUlPWpXFen9K1U/pbhFsZ3VPR5MSrRwG7gc8Y0b9+iJ2U4tkFxM4dQ91x1RCZ0rTbws8tX4bVMGwIbj2PzWnGsQp4EPHl0Q9QeafyGK5mdty9m3eAS1CvfHPsTbF1pi0lDXqtYhPcRx7oFf+TrnUya57/9NaCCPDaBa3Tvm5SyrzUeWoEwV8Ri/GfBvb+RMzNQ1MtTFysYVum/ENCSdzAcsEW/WuDVKWKw27TBHtGq6P7ChvG/Dp50hHG9XOb4DIf7GFxMMH/K2URh8kcoYVVmtM3zFBT4S6m8FxPew38xm2D4cIrE875sQwgBnEKoq9+5DZ/fajlZpMgMsmhTzRBPIrl2tLYl0I/1qBAntqmjmlArhjoJteVfXTyvlkUN2NGiblNDoPDr1oTOFLx5+YrP9X/kVZH40jYLAJ09nQtnMDC+M5q3Ypi5009yWiyj4h+5q0RXVrMsEnwdKYE/oNEaGEmPl1a4HJ7/aAgnHr4pq+Q3tpjJ/tiKnA76s7NFgarExuF6jnMqqHIXThw9uHRNgAphFoMJZl+kI6snMWyeZDNK2CstQhdruMYkeTdjtQkqAsUk04ZWGh1NXMS2ac0vJMaHk8duJweWftTX+Sv0Af/001x2sh0ArwZqPaRJvqbCuLMQ5arE6A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(4326008)(8936002)(15650500001)(478600001)(7696005)(66476007)(52536014)(9686003)(8676002)(26005)(53546011)(6506007)(186003)(66556008)(66446008)(64756008)(2906002)(6636002)(55016002)(83380400001)(76116006)(316002)(5660300002)(71200400001)(110136005)(86362001)(38100700002)(122000001)(33656002)(38070700005)(54906003)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cV0zekljStAnP5baAnipQeN56zbhhqRdznHVTZbXqeF9xbuYRrQlrIUnly8o?=
 =?us-ascii?Q?S9UewlyF0/zqJA+xKnadBrz8YFqziy6MyofNJ5ax7gQYZoKL5HYxuPA3hW4P?=
 =?us-ascii?Q?LSf6yDWVBBVG09GD6L+Xzy+b99e5eqR+sabqYnFicShBSEv30eYeNsW3m6jp?=
 =?us-ascii?Q?yiiHZnawIKEpypkFJBhlN46rHzfWnGsIujEj8fDhmEpHLrv8bOc/kav0ugJa?=
 =?us-ascii?Q?PcYEXr/+EIOL6n+7z0BROYwMLng1i9/zPeD7/4TsLUIeXBQRyxfsRG13q55N?=
 =?us-ascii?Q?qCEaV/JuUFgDnCE0oR5FlCdarg13htuh8GTxYMILuU21MITRnI+WXy2ag7Lq?=
 =?us-ascii?Q?RUjPbOs2fvPpW10pw2dkajPqnn2apJczn/M2s465vOwFJApxPGsfgs8Hbx8A?=
 =?us-ascii?Q?31zoUNuMIihodHMV6pfiu99oSGG2bF/OjLPPRIIbKBL4MIyfLYZvLWZEbQu/?=
 =?us-ascii?Q?hkrJJim0a6qRyfrqLqWGBvDmdSe8kN95vYH0D1YN5mXdsCFQ85Crp2raxJ6J?=
 =?us-ascii?Q?5Tpa4yusjipB22pigRGfFqKQKj9Mk0s8BI8Nj6mZF34LiY/qREqjr4MvU/8u?=
 =?us-ascii?Q?IJMWtJyDfsmz8LqgdnzQ2eQqabdXy3O1Z0U2GgAYcPFo9ucs7FsqiQBf2H65?=
 =?us-ascii?Q?dJ6RvN+EfNN8HnxiHb/u5v3AUEvAYBYujJC3nVDoV4Y5ppJc/0TdjCAHRKg8?=
 =?us-ascii?Q?rrHZl4igA6vX5LZU3IRfdf/Pr3A+xUmVBEaOszvHySmTdfZCadnHDqXKTf6t?=
 =?us-ascii?Q?Be9FHLsLVR8Ut9Iq5SLT8iqWCqieRrRgVAUq1u9ZKfl/CuH4pdRXJH03ynVX?=
 =?us-ascii?Q?iVlzfDRWKYv70lzgT8UBs65tkewWn2dPLxOwDcScTHQxoi4GT08+l22Jmuks?=
 =?us-ascii?Q?6mGYSn+bf3fgjShYMZwdSgctKb2mEZnkGnTun1tGqsxdrw8BEJeiGDZq/Gwz?=
 =?us-ascii?Q?ERkiMzWXFeyMI/TRHgFfred0cjiDF1ZaRHHGf6eF/BSYLNkd7Nh4SZgqQAJx?=
 =?us-ascii?Q?unT5K1ORcxTt9FYMYPaaL5jQXaKDKrggcuTtwBDKwpQWfyoSAxhpquETis8j?=
 =?us-ascii?Q?N4WMJmWZcgd8677mDJ1wAiS+TwjavcRuYlL3sI155MvsJC/X1edbFsp9IBkI?=
 =?us-ascii?Q?5ZgqkyyrHAYewyYKWrK2EvNJuvuKfGKG5hHKi7K/zLPVtV1OIzZEnWJ1GxZI?=
 =?us-ascii?Q?0PV28uqye/YjwK81TAGnEt7/tVsWIWVCImdtgdZ0YVBDlPDGZ0WFk4TLAVYW?=
 =?us-ascii?Q?rz7LklykOb78/FA7G+r8avz57Hnvd5h8Hmkmzf7Ss+uluw9VeYQ6de0g6nw2?=
 =?us-ascii?Q?t5x5j+Bc0OXRFBWa9edNIfJi?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB261971EBCF452097AA846F00E4C19DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85526a67-7bd3-4338-b5fa-08d963805d62
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 02:15:22.2080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzT9LkGPpYrFWsm8apnRFBhomXks2JvmcUzp0kFrRD2baLIkee8mQyLBm2nm5ulo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2826
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

--_000_DM6PR12MB261971EBCF452097AA846F00E4C19DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, August 19, 2021 10:36 PM
To: Zhu, James <James.Zhu@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-gfx=
@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE=
 on suspend


[AMD Official Use Only]

If that is done  -

+               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_T=
YPE_UVD,
+                                                      AMD_PG_STATE_GATE);
+               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_T=
YPE_UVD,
+                                                      AMD_CG_STATE_GATE);

Usual order is CG followed by PG. It comes in the else part, so less likely=
 to happen. Nice to fix for code correctness purpose.
[Quan, Evan] Thanks Lijo. Make sense to me. However, actually these code we=
re copied from amdgpu_uvd_idle_work_handler() of amdgpu_uvd.c. Same logic w=
as used there. So, maybe @Zhu, James<mailto:James.Zhu@amd.com> or @Liu, Leo=
<mailto:Leo.Liu@amd.com> can share some insights about this.

BR
Evan

Thanks,
Lijo

From: Zhu, James <James.Zhu@amd.com<mailto:James.Zhu@amd.com>>
Sent: Thursday, August 19, 2021 7:49 PM
To: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; =
Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Pan, Xinhui <X=
inhui.Pan@amd.com<mailto:Xinhui.Pan@amd.com>>
Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE=
 on suspend


[AMD Official Use Only]


Why not move changes into hw_fini?


Best Regards!



James Zhu

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Evan Quan <evan.quan@amd.com<mailto:e=
van.quan@amd.com>>
Sent: Wednesday, August 18, 2021 11:08 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; =
Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Quan, Evan <Ev=
an.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Pan, Xinhui <Xinhui.Pan@amd.com=
<mailto:Xinhui.Pan@amd.com>>
Subject: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on =
suspend

Perform proper cleanups on UVD/VCE suspend: powergate enablement,
clockgating enablement and dpm disablement. This can fix some hangs
observed on suspending when UVD/VCE still using(e.g. issue
"pm-suspend" when video is still playing).

Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
Signed-off-by: Evan Quan <evan.quan@amd.com<mailto:evan.quan@amd.com>>
Signed-off-by: xinhui pan <xinhui.pan@amd.com<mailto:xinhui.pan@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c
index 4eebf973a065..d0fc6ec18c29 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)
         int r;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       /*
+        * Proper cleanups before halting the HW engine:
+        *   - cancel the delayed idle work
+        *   - enable powergating
+        *   - enable clockgating
+        *   - disable dpm
+        *
+        * TODO: to align with the VCN implementation, move the
+        * jobs for clockgating/powergating/dpm setting to
+        * ->set_powergating_state().
+        */
+       cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+       if (adev->pm.dpm_enabled) {
+               amdgpu_dpm_enable_uvd(adev, false);
+       } else {
+               amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+               /* shutdown the UVD block */
+               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_T=
YPE_UVD,
+                                                      AMD_PG_STATE_GATE);
+               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_T=
YPE_UVD,
+                                                      AMD_CG_STATE_GATE);
+       }
+
         r =3D uvd_v6_0_hw_fini(adev);
         if (r)
                 return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c
index 6d9108fa22e0..a594ade5d30a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)
         int r;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       /*
+        * Proper cleanups before halting the HW engine:
+        *   - cancel the delayed idle work
+        *   - enable powergating
+        *   - enable clockgating
+        *   - disable dpm
+        *
+        * TODO: to align with the VCN implementation, move the
+        * jobs for clockgating/powergating/dpm setting to
+        * ->set_powergating_state().
+        */
+       cancel_delayed_work_sync(&adev->vce.idle_work);
+
+       if (adev->pm.dpm_enabled) {
+               amdgpu_dpm_enable_vce(adev, false);
+       } else {
+               amdgpu_asic_set_vce_clocks(adev, 0, 0);
+               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_T=
YPE_VCE,
+                                                      AMD_PG_STATE_GATE);
+               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_T=
YPE_VCE,
+                                                      AMD_CG_STATE_GATE);
+       }
+
         r =3D vce_v3_0_hw_fini(adev);
         if (r)
                 return r;
--
2.29.0

--_000_DM6PR12MB261971EBCF452097AA846F00E4C19DM6PR12MB2619namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Thursday, August 19, 2021 10:36 PM<br>
<b>To:</b> Zhu, James &lt;James.Zhu@amd.com&gt;; Quan, Evan &lt;Evan.Quan@a=
md.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 =
UVD/VCE on suspend<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If that is done &nbsp;&#8211; <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_set_powergating_state(ad=
ev, AMD_IP_BLOCK_TYPE_UVD,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_U=
VD,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GATE);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Usual order is CG followed by PG. It comes in the el=
se part, so less likely to happen. Nice to fix for code correctness purpose=
.<o:p></o:p></p>
<p class=3D"MsoNormal"><b><i>[Quan, Evan] Thanks Lijo. Make sense to me. Ho=
wever, actually these code were copied from amdgpu_uvd_idle_work_handler() =
of amdgpu_uvd.c. Same logic was used there. So, maybe
<a id=3D"OWAAM189CC8F3B09847EEA52C17F4845930BF" href=3D"mailto:James.Zhu@am=
d.com"><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decor=
ation:none">@Zhu, James</span></a> or
<a id=3D"OWAAM005ACA333EA6426EAFED0E7C5A403D96" href=3D"mailto:Leo.Liu@amd.=
com"><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decorat=
ion:none">@Liu, Leo</span></a> can share some insights about this.<o:p></o:=
p></i></b></p>
<p class=3D"MsoNormal"><b><i><o:p>&nbsp;</o:p></i></b></p>
<p class=3D"MsoNormal"><b><i>BR<o:p></o:p></i></b></p>
<p class=3D"MsoNormal"><b><i>Evan</i></b><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhu, James &lt;<a href=3D"mailto:James.=
Zhu@amd.com">James.Zhu@amd.com</a>&gt;
<br>
<b>Sent:</b> Thursday, August 19, 2021 7:49 PM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:G=
uchun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D=
"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;;
 Pan, Xinhui &lt;<a href=3D"mailto:Xinhui.Pan@amd.com">Xinhui.Pan@amd.com</=
a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 =
UVD/VCE on suspend<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Why not=
 move changes into</span><span style=3D"color:black"> hw_fini?</span><span =
style=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Best Regards!<o:p></o:p></s=
pan></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">James Zhu<o:p></o:p></span>=
</p>
</div>
</div>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com">evan.quan@amd.com</a>&=
gt;<br>
<b>Sent:</b> Wednesday, August 18, 2021 11:08 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:G=
uchun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D=
"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;;
 Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@amd.com</a>&=
gt;; Pan, Xinhui &lt;<a href=3D"mailto:Xinhui.Pan@amd.com">Xinhui.Pan@amd.c=
om</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/=
VCE on suspend</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Perform proper cleanu=
ps on UVD/VCE suspend: powergate enablement,<br>
clockgating enablement and dpm disablement. This can fix some hangs<br>
observed on suspending when UVD/VCE still using(e.g. issue<br>
&quot;pm-suspend&quot; when video is still playing).<br>
<br>
Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com">evan.quan=
@amd.com</a>&gt;<br>
Signed-off-by: xinhui pan &lt;<a href=3D"mailto:xinhui.pan@amd.com">xinhui.=
pan@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++<br=
>
&nbsp;2 files changed, 47 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c<br>
index 4eebf973a065..d0fc6ec18c29 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
@@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups before haltin=
g the HW engine:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cancel the dela=
yed idle work<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable powergat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable clockgat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - disable dpm<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: to align with the VCN i=
mplementation, move the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * jobs for clockgating/powergat=
ing/dpm setting to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * -&gt;set_powergating_state().=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&g=
t;uvd.idle_work);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_enable_uvd(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_asic_set_uvd_clocks(adev, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* shutdown the UVD block */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_U=
VD,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_U=
VD,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D uvd_v6_0_hw_fini(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c<br>
index 6d9108fa22e0..a594ade5d30a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
@@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups before haltin=
g the HW engine:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cancel the dela=
yed idle work<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable powergat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable clockgat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - disable dpm<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: to align with the VCN i=
mplementation, move the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * jobs for clockgating/powergat=
ing/dpm setting to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * -&gt;set_powergating_state().=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&g=
t;vce.idle_work);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_enable_vce(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_asic_set_vce_clocks(adev, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_V=
CE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_V=
CE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vce_v3_0_hw_fini(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
-- <br>
2.29.0<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB261971EBCF452097AA846F00E4C19DM6PR12MB2619namp_--
