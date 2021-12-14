Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD7BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 07:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75AF510E889;
	Tue, 14 Dec 2021 07:39:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D665910E889
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 07:39:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpDQB9MIFwfQdZbt4g6FYoCpms+2UG+YVHLP6tdBmMYyB1naGnTEJsk/6/G4LlYR2hIcOeCdqTYohz2JdCAqnqYE0JSPD1R3wsXICeQcePqiJu1S/OXMKC4qietY1oQ1mmgXdp4KdMeksfojs9E+1lUD4L1G/vsM7rZWjCnVDIO7AYg7zERF3aOq66oJAaZJde/f2/a4tw579v3j1d9Pu8LaiNHsL+fENUD+McHgJeNJj0IYb47Coh83EA/cDIpAWgx8ok5nUjlNUKd9Le7BFFV64ygK2v9QODsqcVlvWSy19KKtfE1W9BlzKgV1zpAHxRrR+xnYPALHNPR9Sytpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pproMgOdwcEGDQcnJKsC7Z9LsgdtHzthLggkiiY4b2M=;
 b=lxvtgIVdhN+yHUrd0qyAoQK7m4fKKTWzc2cG1P7WomLJFS/TwaVwve36zsZc9fTHSkccLFSuU5eH257Zwsr7/XOXoZv8/gHZx1Y28FxrBF0xXR6g7hSsjESUaHVqskX26l6dRT9EXcS0Se8XLh5/xjO+tQ4pt5mBDEDjZj/48hdYRTjDx/34qocyTrI+oIzyto1lWOTDb9J344vFalG/oX2J5d3oWy5V4tvjsii7JFDr+dperEQquItD5AyiO8ORIYD4yma0+EIkSpMHqfXn6s4VFGIoK51jtuMKqA2cb7zJpUkPMYSOMBGbzEWs6KiaUIilgPmQXHV+xWQjUymM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pproMgOdwcEGDQcnJKsC7Z9LsgdtHzthLggkiiY4b2M=;
 b=bx3J3k2JKfC4cgSB2JmqOEO9mgkxpJc1g1c5GCBZrbT61y36NX75qNfO36A8uCsiy/bWZHFDhS5a8ktAQlxZ23zU2VjV9GAYJCl+TPnhao4FvlNGpKrlrohjIt7Dh2MVY1Lg8qaWSVOqfYRWHHequn+SVTkW9EHtih5N5SPz1SA=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 14 Dec
 2021 07:39:05 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::c457:ec1b:7d79:632b]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::c457:ec1b:7d79:632b%6]) with mapi id 15.20.4755.021; Tue, 14 Dec 2021
 07:39:05 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/2] drm/amd/amdgpu: fix psp tmr bo pin count leak in
 SRIOV
Thread-Topic: [PATCH v2 1/2] drm/amd/amdgpu: fix psp tmr bo pin count leak in
 SRIOV
Thread-Index: AQHX8KGjNBH7QmpCV0GlyhlqXVJi0KwxmfaQ
Date: Tue, 14 Dec 2021 07:39:04 +0000
Message-ID: <DM4PR12MB5072EA868CC2F54F8A5F6C68E1759@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20211214041751.23647-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20211214041751.23647-1-Jingwen.Chen2@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=91f327d9-ac20-4d6a-9fe9-22084dd3a1d8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-14T07:38:40Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3f9b8d3-fc6a-4d66-d23b-08d9bed4ce3f
x-ms-traffictypediagnostic: DM8PR12MB5480:EE_
x-microsoft-antispam-prvs: <DM8PR12MB54803B848B0048E726D2BD57E1759@DM8PR12MB5480.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SnH+uFv/iwLwzlfqwdBv7DfGQK4CVtoakgJUKAdmB/7x0MnTYK60crvXtWcIktx0G2yXFMX5vzcWErvheD6i576gRAMsNJ3dyHB1hv6GLN/Cz9wwqNyIAN8DNr1XCiy133dQYIKWTuI9NQ+5kbc4WzlW7nU1PukEYNfhuNZ/S2EEbRz0TVVgY14+ylm+Gy1Wh2Sc950toRAyGFepy0b/9PTH2VKp/zOtykBcqNDHMiuYs7lOzYiZWk7UZ8QbYMkJrEWklIUEH0V1GpEhqHy0ATvhtAZymeX97FihW7fVP2NkLYfThDPDwSV/gJPOa0lx9Uzs035Gn0tiiXIC4813sK1P0kJBc3R87UVVjXlt5Qj4Hs9X+SlGskJtLmHq6xP3FMwaSWkuoiqu5+MGgmjCZVkoh9McryU/Big7X90uGOVkTQBadnMyeFJbZP3JBmaA/6lR7Yigetznw6X0iCxPQr4cSYpkWAPXiq9PCoTQzr3xW+3B77jl9d61FA9PNzx7eYsj9yGPKPcPqLfT2uIriezC34t+crXRX1HpcIylJJcBn/aI3gl5Flsv61bRwJTchh4Onr1JulaKdOKrFaoZngKtgOB51jXgUXyfat2EDwwXcSgU7zIt8dB1dfyXEByksKvtRlKyewCXamkMemhRjIQxa9naj4S/txHIVWFuxYsPjJKETypHEjUOYaKYxhODcBn0r6JjtSRaWrgtDfLmJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(8936002)(76116006)(5660300002)(66946007)(38100700002)(2906002)(6506007)(7696005)(33656002)(66476007)(110136005)(66556008)(64756008)(66446008)(53546011)(4326008)(316002)(26005)(83380400001)(55016003)(122000001)(71200400001)(186003)(9686003)(52536014)(38070700005)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?usawv+W8At8FppDxEtGlmeMxm1epRBdnEOWC/GrG+tQC9mmt7wSSPwnarzjX?=
 =?us-ascii?Q?myrPry1ldvQ7BchcZwaKaylNuGJVOFkMN88NchNV3K2zEQVyAeDO87DK+4JB?=
 =?us-ascii?Q?hrNEfvRqjVxmIPC/wR+w0K3fZGka0PxkfedUm5XmllgEBm5PhAMTEwuVSH6o?=
 =?us-ascii?Q?IT9LJtIgf9HQCrHb4FIwBYbFnWjI0zDRIxWOF31rEIKon4hTA0td4J15HNeW?=
 =?us-ascii?Q?7h8Mc++CvB7NAH3HxR74TAOQkLx8qQIiIAUTnCRbej/fs+Nwtl1hXycyKK3b?=
 =?us-ascii?Q?A7pkhDhOTvgyuumz8K0GEwzJUCd8i83tSujvhMown4+FJrp8N2nTzvM9m5NU?=
 =?us-ascii?Q?G+UZ2PVYTaFe+2CdEevk97DfdEIZ1OKkDgq0zzVMasw9VwL3eQn0SldLQmV5?=
 =?us-ascii?Q?6qQ8T8ItTjjxzDYiBVaENaTmysni4stw3QSF12ITDiD/vEBBehw7u2BcNnHv?=
 =?us-ascii?Q?8/vONxyLWMOsTfnyYycIDKay66vKdSB2C7Zl2eEySgYdGewAviHF5EY8JTDO?=
 =?us-ascii?Q?IRR5D7JXJJkSGRgQ5ol4s+p+1Pv5Rbn2otDLrBGqleFvt8GccPAg3yzYR3Cc?=
 =?us-ascii?Q?Qh9K3Hmpwo2bqpR/JJH+Dk43iGnOAVZrOwsWoVR6lEIEB5z6VxN7SOCfAt7Z?=
 =?us-ascii?Q?Uv5kFQTGvD1pNhhOhAesPuqnhB/UgMbQ1J+g2LhwQvF9KrUBv/qFYLBeIodC?=
 =?us-ascii?Q?UB/GWpRb1nNSauyqbLdaTniYeV/37R89WltZdrrbsbUGsChjB4uutNLmoauS?=
 =?us-ascii?Q?fTfYl2DmHj8+bjJRUgOA2/aRxPBGl2H4BADJbncZFJIboUJdgdOnCOmaN2tm?=
 =?us-ascii?Q?IQyDoCPdu7ex30tYxtQ7Ch3z9vucQwVFP5tlMYZct+au+tLkyndpU/+wlYYb?=
 =?us-ascii?Q?Y5yGA1dqK11zt7WSYSTl2+PeCI9V7ttJ/wVsBQJWtmnVhXEe94WixMyr1/LT?=
 =?us-ascii?Q?qjO8t0MRHA5uKxWi6exWCtYkxf/SQczIxP7OV4mayNNkN9YMHViUnJf9iBWF?=
 =?us-ascii?Q?Ul3qpouCMqo1uKqyX2a8JCYfrvn9GVx3nnzCxMaBZCzuWYZgDUkziFIpPpDx?=
 =?us-ascii?Q?ZwqQ/kzpgzD6s5CsLn8kalcSQIa1zPMU4XbgWGSHZzuIEQ27GV2jaG6esJbb?=
 =?us-ascii?Q?rSPeyUtWX5D/X7GfXB/pdP0xgidIxKQQxFoh1Jm8Plxfm1SN12a1RGrCyPuT?=
 =?us-ascii?Q?Qf5cP6rSWIvtKG2dol1bPNGTsNdQgaKBNQUlfEfLG77jFSOFZZjXG7DCBYKF?=
 =?us-ascii?Q?KyFSsL851aWEZVrWKLxBOBsRuq3+noyvMfZMZp7f2HLVWSMWrjB7w++Npa/p?=
 =?us-ascii?Q?o9p9JBAtpPgUeA6jqjnMVtNps7+sS8X5K5dF6UvoUsznkuwVlPn5a5jF9r9X?=
 =?us-ascii?Q?iDfm0i3O9CTnmXA7YNimJvf2TL4buM7fK8Lch+NyfaQS9fbb8llTbhFR4gRQ?=
 =?us-ascii?Q?OoyLJJU1LmwwkGSX3vh2cmJsza2741dYXV9ydurUSjfoVZxZ7H/Gc5mfueKN?=
 =?us-ascii?Q?2J5Rt3fYgrGrsQ9jEoBmaSJM4ruFBnlrO7/s/G9U9Cv5zCJkp7nax4Jjh5/S?=
 =?us-ascii?Q?Ca5Nri+THhFH3+Pdk4E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f9b8d3-fc6a-4d66-d23b-08d9bed4ce3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 07:39:05.0954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhloR/TEgqAgJD5+tvabUbqxjEUjZ/N6tbT1JGhQoRdJEp/r3sjJWwbdgiwi51+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5480
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Horace Chen <horace.chen@amd.com>

-----Original Message-----
From: Chen, JingWen <JingWen.Chen2@amd.com>
Sent: Tuesday, December 14, 2021 12:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Chen,=
 JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH v2 1/2] drm/amd/amdgpu: fix psp tmr bo pin count leak in SR=
IOV

[Why]
psp tmr bo will be pinned during loading amdgpu and reset in SRIOV while on=
ly unpinned in unload amdgpu

[How]
add amdgpu_in_reset and sriov judgement to skip pin bo

v2: fix wrong judgement

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 103bcadbc8b8..4de46fcb486c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2017,12 +2017,16 @@ static int psp_hw_start(struct psp_context *psp)
                return ret;
        }

+       if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
+               goto skip_pin_bo;
+
        ret =3D psp_tmr_init(psp);
        if (ret) {
                DRM_ERROR("PSP tmr init failed!\n");
                return ret;
        }

+skip_pin_bo:
        /*
         * For ASICs with DF Cstate management centralized
         * to PMFW, TMR setup should be performed after PMFW
--
2.30.2

