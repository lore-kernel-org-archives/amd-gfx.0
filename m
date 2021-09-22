Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0D8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 15:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D220611C6
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 15:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D220611C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061816EC08;
	Wed, 22 Sep 2021 15:19:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38EC46EC08
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 15:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcoGO9ZZ+5u9CnynU9nKR7JaoVDDuudfqvPDgMf6Xf456CMAx3fUrfYR+ErZYkgRUgvoAkZKZpzYzIa0qOFF5ACnVKZc9DPyFzYvhw57ZtQki4WVodq1HJWgqnV4LYNtPq/jkLvTw8ea+NLInC0mKQfemGnfAM5QIATfZxgZFo1W3J1+oMXlK7ZdqG9xiPMEPquYAfdD4WwhNxz8JlS3LeVXa0sFSnxI46E82qQonHhDw2n3zPMpVSC8HmHMLwn0ACshMeK8vHfihfLVcIiS/QEaE6rlOQRRaHL4jWdptlcB3efJM35GPIkJ2i+t6p1Qg0GRH2tYuxwXsBmYQ1eLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=84oc8R8LnaaS89t2/zs7sYvk5AWdyuysIcmzDU0NYTA=;
 b=a91iAOZDPBatzmqZ/WEGlKinYdd04ER3fwgbCUT4HGECBr5pA4yZu4ay/5blokVcRQb/LA68yS/NoXRY0edi9pshSIVYPVNN+EBXNfkgkDzJzHXjRXOMHWeLP1u5mMXYMhIhQSXSmotTSUAMchaffBGIHs4cHf8YGGmxqdue524X673GInW+9WRG/NASRAdzdG0KN/9lU2QmHEUpMMG/5Q79vmOfGTTiX+HseNA5YhRiR0oSl3auM8iHLo9Qnk2a0DzpUDQmSD93h9KCB6kTmcTr5QVQJVf1SFHy9rIBIYAwGBJ2DATunjiKNfBg1x46O6ucGyq617dSwB5FIJJxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84oc8R8LnaaS89t2/zs7sYvk5AWdyuysIcmzDU0NYTA=;
 b=5dhWaNyasHQJjtxlrCiSesVY39oXPmjk6j3Z2qz7y6F+fHBSY6Z0aPkGBhsxodZkT4SZcGPAyzvbyUz3LpZNiC96eCZTy1Rr5E2PTqaEnMCBvzrbLZ8pjVa+CBETrKy2OtHaHsjnL2/aH7h4DOQaT6FbJSgOag99yp0vTcnpvV8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 22 Sep
 2021 15:19:02 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 15:19:01 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 11/66] drm/amdgpu: filter out radeon PCI device IDs
Thread-Topic: [PATCH 11/66] drm/amdgpu: filter out radeon PCI device IDs
Thread-Index: AQHXrxOVUXekMWMI60u9ML+I5XpTequvejSAgACx844=
Date: Wed, 22 Sep 2021 15:19:01 +0000
Message-ID: <BL1PR12MB51445F87807DE02B7BA11EF4F7A29@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-12-alexander.deucher@amd.com>
 <e13b4e41-7474-b2ef-fafb-ef06a53dcba8@amd.com>
In-Reply-To: <e13b4e41-7474-b2ef-fafb-ef06a53dcba8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-22T15:19:01.305Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 451f06b6-517b-3a18-7f88-8652a5432d09
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e4fb044-1a97-44a0-4f3e-08d97ddc4ee9
x-ms-traffictypediagnostic: BL1PR12MB5111:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB51110CC18D1873CF1C79C090F7A29@BL1PR12MB5111.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RBIY/HkijSOyQQ6NtzWV24OtqiCmsW/ZGR/kgoPKRKygxj89xk4MkpiRRU+zaHuxcmx5tKIE2Prx9R1yl3Ms8cS7uTnvP2EdfWtclYNFRss6Y//CXTNy8yBEQnQO8Rd1ku46ygO80N/ruc+4tftfeYqXg6WCRsBviq0j1V/nanbk7yHhKnpfuN83zCp24n8Xq4vWV4GGrvXWMg3YI9yIRO4blhhy9YlfSk398tZRXlR1dOHZCjr/6IS5Guw0ze+I0ecnyWdFRbzmm1bWw71wXhgsuKFLgKP0OkmIK84r+mwXPMoTnskmeLUVb4eocDpKDqw3oVYv2yzbje2Vwtlfa8k3V5ordsNlBHXlVmshYfxjQfnonWG9ntySmAkG+lTq1qEdYCBV6VGFyzePhRN5S7VzO+N4kjk6BJpjWC+tG2+M08e3y4T6r4oIKQ3L2pB6T1GxcjspA2eTGNMO+qfGoNc0Ad1Gk1nK80LKVDHWb8V1UlymnnxklESson3/hdijUbx0wldukALrwuqgj8l9ZDj074YwoP/4xkHb3UhtZMLuuaiB5EHM3wZNXWT0SSAqLFBdY7Cg1/4EE8Fk52VeUPor0M0OY+LP7UuzGmxsHa475D63GhTUtc25ZSWJu5Dp6KHWKsGhYZqGW1CtOouN/jX76BwM75ZFyoeG1nY7bCKjd+3iEwFBIRcIs07dSsu7x6jXFqjg6maI+cmhR7bOfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(508600001)(19627405001)(8676002)(26005)(55016002)(38100700002)(122000001)(186003)(8936002)(52536014)(7696005)(86362001)(38070700005)(71200400001)(9686003)(64756008)(66476007)(66556008)(66946007)(5660300002)(33656002)(110136005)(76116006)(316002)(6506007)(53546011)(66446008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6W78fmwIk3/v2ZaA0BLH+3vRKn96isS4dsnG1hcGrAvDRbNfAQs7c8u/uAcj?=
 =?us-ascii?Q?DG267Naqu61HzjWLmDAHAKfDWL3jVG8zvr45BTJnlqcnSe1kLfLrcsFoqy5K?=
 =?us-ascii?Q?T37m/V89AFABh+JUL5qMffcd0vcuZKxzN93Ecziqto6cAdgJY40tmhMQ7y+K?=
 =?us-ascii?Q?15uQTDeZPrsWcX79kbDK+44+1IaNUG8fVnzPX8P7SAlgT/lewJWfH+zvKXvw?=
 =?us-ascii?Q?RNoxnGY61X6Rs0xG9yo+Xnf54XVUjMCZMoiuAfP3H/Kxq3RbP6ozhz3Gb44G?=
 =?us-ascii?Q?XMIFeylS1nGg0Cigln4+nC3glKmvAI+imKA3cBEt4PTlaQMXKRBV7yC//k5U?=
 =?us-ascii?Q?Qac0jpsdg+ZtXCe8n2HDARSJlxmvG20zjr6q/OQJpLShqvk94c8zz0XZEhFR?=
 =?us-ascii?Q?2m3BcFfqQ4pK6x9MTvzB25dxD9kqWzukKTV9lzXoivB+WFbqk2XFia89grYO?=
 =?us-ascii?Q?eNpj29rKnQEXY0cDuJQdIRTHoiwiJucw4sg7JXUIW3i6+I58kpGMMO5NHYTy?=
 =?us-ascii?Q?ggO9oQEyL5m9f1nz5IbK+01vacZ1otd19mgR5SkWf9f4+UNIzHRENfo4mXla?=
 =?us-ascii?Q?lVn3zWL7p5cucrvyzcPDbD/cSLNxTGL5BUVC3jM9LgcKl6LDbe1O+W2PmMys?=
 =?us-ascii?Q?hHy+IQ1Sb3501HVNUJN7Hqc1Ox1SR1d12j0vL2X2e6kD3ReKngcf6zSOY6nr?=
 =?us-ascii?Q?rOmPUAtr89z1dJmaaitPkE2xCxONvBQFtoOXVEWGyvGAdoG2PcdjG18mBfJf?=
 =?us-ascii?Q?mEk4UAq3+toE3ox752NtNnvmiNJ/w5vqP+3OWuwFsQ0roP4dlOy3Qcr2bFP2?=
 =?us-ascii?Q?M+XQ7VnH/myQ3/zKnTlz6DDsLMhMtriVGHMQUVXbRKxtGQY6wqP8NRy8aWbC?=
 =?us-ascii?Q?MTjsFvFoDVyLanTZ6Gc55VwUS2E39bHxY7AJB8PBSM1iDtY3mEsxlWngcO0F?=
 =?us-ascii?Q?qnTF5cN+luBeA5N7v/wEeSQArwV2yb2cjqRuf9gR+7Pozqb1Bc6BuhlZ0vQi?=
 =?us-ascii?Q?12TWwrt0/t9W+Jt8rAybOyiBiMAUwZn8+8BTe2dYRXxznG3eNIMsutrLIyB3?=
 =?us-ascii?Q?xwCrFzu4LBZLipyqA9z5AUoDwuM/fKmls/efJO7WsevT7FCB30M/ksM46LHb?=
 =?us-ascii?Q?Vh6ZVkKRzypuajHibAjUjuis0XngcDRooWrLPw55tbgerY9BZkU8s8rqqszg?=
 =?us-ascii?Q?V9oGtAIaF1rV0bBixk7H5G6fSrCZfa/8Xi+N7p+gG8fQI5fCd7qRjZSU13fH?=
 =?us-ascii?Q?usSnwW+91Ywh5RWJX1UtjsQRoHrlhO3jREXkMf7rxja7iSmqloTlAOnY7jK0?=
 =?us-ascii?Q?XKfpx914xZ4OKDEEMzAeDK4m?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51445F87807DE02B7BA11EF4F7A29BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4fb044-1a97-44a0-4f3e-08d97ddc4ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 15:19:01.9019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2+5qCwgoypkb9b7FM7B8xlVprBfmuXbq/PN6Hu4ui1gaD+28rPTXUiGySx0TGl+XzlcpV80VR8OhBwx82PtBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
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

--_000_BL1PR12MB51445F87807DE02B7BA11EF4F7A29BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Fixed locally.  Thanks!
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, September 22, 2021 12:41 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 11/66] drm/amdgpu: filter out radeon PCI device IDs



On 9/21/2021 11:36 PM, Alex Deucher wrote:
> Once we claim all 0x1002 PCI display class devices, we will
> need to filter out devices owned by radeon.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 561 +++++++++++++++++++++++-
>   1 file changed, 560 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b6ce53fa9b03..3ab7099a1b16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -891,6 +891,559 @@ MODULE_PARM_DESC(smu_pptable_id,
>        "specify pptable id to be used (-1 =3D auto(default) value, 0 =3D =
use pptable from vbios, > 0 =3D soft pptable id)");
>   module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
>
> +static const u16 radeon_pciidlist[] =3D {

Instead of associating to only radeon, maybe rename to something more
generic such that all device ids in the list will be skipped.

Thanks,
Lijo

> +     0x3150,
> +     0x3151,
> +     0x3152,
> +     0x3154,
> +     0x3155,
> +     0x3E50,
> +     0x3E54,
> +     0x4136,
> +     0x4137,
> +     0x4144,
> +     0x4145,
> +     0x4146,
> +     0x4147,
> +     0x4148,
> +     0x4149,
> +     0x414A,
> +     0x414B,
> +     0x4150,
> +     0x4151,
> +     0x4152,
> +     0x4153,
> +     0x4154,
> +     0x4155,
> +     0x4156,
> +     0x4237,
> +     0x4242,
> +     0x4336,
> +     0x4337,
> +     0x4437,
> +     0x4966,
> +     0x4967,
> +     0x4A48,
> +     0x4A49,
> +     0x4A4A,
> +     0x4A4B,
> +     0x4A4C,
> +     0x4A4D,
> +     0x4A4E,
> +     0x4A4F,
> +     0x4A50,
> +     0x4A54,
> +     0x4B48,
> +     0x4B49,
> +     0x4B4A,
> +     0x4B4B,
> +     0x4B4C,
> +     0x4C57,
> +     0x4C58,
> +     0x4C59,
> +     0x4C5A,
> +     0x4C64,
> +     0x4C66,
> +     0x4C67,
> +     0x4E44,
> +     0x4E45,
> +     0x4E46,
> +     0x4E47,
> +     0x4E48,
> +     0x4E49,
> +     0x4E4A,
> +     0x4E4B,
> +     0x4E50,
> +     0x4E51,
> +     0x4E52,
> +     0x4E53,
> +     0x4E54,
> +     0x4E56,
> +     0x5144,
> +     0x5145,
> +     0x5146,
> +     0x5147,
> +     0x5148,
> +     0x514C,
> +     0x514D,
> +     0x5157,
> +     0x5158,
> +     0x5159,
> +     0x515A,
> +     0x515E,
> +     0x5460,
> +     0x5462,
> +     0x5464,
> +     0x5548,
> +     0x5549,
> +     0x554A,
> +     0x554B,
> +     0x554C,
> +     0x554D,
> +     0x554E,
> +     0x554F,
> +     0x5550,
> +     0x5551,
> +     0x5552,
> +     0x5554,
> +     0x564A,
> +     0x564B,
> +     0x564F,
> +     0x5652,
> +     0x5653,
> +     0x5657,
> +     0x5834,
> +     0x5835,
> +     0x5954,
> +     0x5955,
> +     0x5974,
> +     0x5975,
> +     0x5960,
> +     0x5961,
> +     0x5962,
> +     0x5964,
> +     0x5965,
> +     0x5969,
> +     0x5a41,
> +     0x5a42,
> +     0x5a61,
> +     0x5a62,
> +     0x5b60,
> +     0x5b62,
> +     0x5b63,
> +     0x5b64,
> +     0x5b65,
> +     0x5c61,
> +     0x5c63,
> +     0x5d48,
> +     0x5d49,
> +     0x5d4a,
> +     0x5d4c,
> +     0x5d4d,
> +     0x5d4e,
> +     0x5d4f,
> +     0x5d50,
> +     0x5d52,
> +     0x5d57,
> +     0x5e48,
> +     0x5e4a,
> +     0x5e4b,
> +     0x5e4c,
> +     0x5e4d,
> +     0x5e4f,
> +     0x6700,
> +     0x6701,
> +     0x6702,
> +     0x6703,
> +     0x6704,
> +     0x6705,
> +     0x6706,
> +     0x6707,
> +     0x6708,
> +     0x6709,
> +     0x6718,
> +     0x6719,
> +     0x671c,
> +     0x671d,
> +     0x671f,
> +     0x6720,
> +     0x6721,
> +     0x6722,
> +     0x6723,
> +     0x6724,
> +     0x6725,
> +     0x6726,
> +     0x6727,
> +     0x6728,
> +     0x6729,
> +     0x6738,
> +     0x6739,
> +     0x673e,
> +     0x6740,
> +     0x6741,
> +     0x6742,
> +     0x6743,
> +     0x6744,
> +     0x6745,
> +     0x6746,
> +     0x6747,
> +     0x6748,
> +     0x6749,
> +     0x674A,
> +     0x6750,
> +     0x6751,
> +     0x6758,
> +     0x6759,
> +     0x675B,
> +     0x675D,
> +     0x675F,
> +     0x6760,
> +     0x6761,
> +     0x6762,
> +     0x6763,
> +     0x6764,
> +     0x6765,
> +     0x6766,
> +     0x6767,
> +     0x6768,
> +     0x6770,
> +     0x6771,
> +     0x6772,
> +     0x6778,
> +     0x6779,
> +     0x677B,
> +     0x6840,
> +     0x6841,
> +     0x6842,
> +     0x6843,
> +     0x6849,
> +     0x684C,
> +     0x6850,
> +     0x6858,
> +     0x6859,
> +     0x6880,
> +     0x6888,
> +     0x6889,
> +     0x688A,
> +     0x688C,
> +     0x688D,
> +     0x6898,
> +     0x6899,
> +     0x689b,
> +     0x689c,
> +     0x689d,
> +     0x689e,
> +     0x68a0,
> +     0x68a1,
> +     0x68a8,
> +     0x68a9,
> +     0x68b0,
> +     0x68b8,
> +     0x68b9,
> +     0x68ba,
> +     0x68be,
> +     0x68bf,
> +     0x68c0,
> +     0x68c1,
> +     0x68c7,
> +     0x68c8,
> +     0x68c9,
> +     0x68d8,
> +     0x68d9,
> +     0x68da,
> +     0x68de,
> +     0x68e0,
> +     0x68e1,
> +     0x68e4,
> +     0x68e5,
> +     0x68e8,
> +     0x68e9,
> +     0x68f1,
> +     0x68f2,
> +     0x68f8,
> +     0x68f9,
> +     0x68fa,
> +     0x68fe,
> +     0x7100,
> +     0x7101,
> +     0x7102,
> +     0x7103,
> +     0x7104,
> +     0x7105,
> +     0x7106,
> +     0x7108,
> +     0x7109,
> +     0x710A,
> +     0x710B,
> +     0x710C,
> +     0x710E,
> +     0x710F,
> +     0x7140,
> +     0x7141,
> +     0x7142,
> +     0x7143,
> +     0x7144,
> +     0x7145,
> +     0x7146,
> +     0x7147,
> +     0x7149,
> +     0x714A,
> +     0x714B,
> +     0x714C,
> +     0x714D,
> +     0x714E,
> +     0x714F,
> +     0x7151,
> +     0x7152,
> +     0x7153,
> +     0x715E,
> +     0x715F,
> +     0x7180,
> +     0x7181,
> +     0x7183,
> +     0x7186,
> +     0x7187,
> +     0x7188,
> +     0x718A,
> +     0x718B,
> +     0x718C,
> +     0x718D,
> +     0x718F,
> +     0x7193,
> +     0x7196,
> +     0x719B,
> +     0x719F,
> +     0x71C0,
> +     0x71C1,
> +     0x71C2,
> +     0x71C3,
> +     0x71C4,
> +     0x71C5,
> +     0x71C6,
> +     0x71C7,
> +     0x71CD,
> +     0x71CE,
> +     0x71D2,
> +     0x71D4,
> +     0x71D5,
> +     0x71D6,
> +     0x71DA,
> +     0x71DE,
> +     0x7200,
> +     0x7210,
> +     0x7211,
> +     0x7240,
> +     0x7243,
> +     0x7244,
> +     0x7245,
> +     0x7246,
> +     0x7247,
> +     0x7248,
> +     0x7249,
> +     0x724A,
> +     0x724B,
> +     0x724C,
> +     0x724D,
> +     0x724E,
> +     0x724F,
> +     0x7280,
> +     0x7281,
> +     0x7283,
> +     0x7284,
> +     0x7287,
> +     0x7288,
> +     0x7289,
> +     0x728B,
> +     0x728C,
> +     0x7290,
> +     0x7291,
> +     0x7293,
> +     0x7297,
> +     0x7834,
> +     0x7835,
> +     0x791e,
> +     0x791f,
> +     0x793f,
> +     0x7941,
> +     0x7942,
> +     0x796c,
> +     0x796d,
> +     0x796e,
> +     0x796f,
> +     0x9400,
> +     0x9401,
> +     0x9402,
> +     0x9403,
> +     0x9405,
> +     0x940A,
> +     0x940B,
> +     0x940F,
> +     0x94A0,
> +     0x94A1,
> +     0x94A3,
> +     0x94B1,
> +     0x94B3,
> +     0x94B4,
> +     0x94B5,
> +     0x94B9,
> +     0x9440,
> +     0x9441,
> +     0x9442,
> +     0x9443,
> +     0x9444,
> +     0x9446,
> +     0x944A,
> +     0x944B,
> +     0x944C,
> +     0x944E,
> +     0x9450,
> +     0x9452,
> +     0x9456,
> +     0x945A,
> +     0x945B,
> +     0x945E,
> +     0x9460,
> +     0x9462,
> +     0x946A,
> +     0x946B,
> +     0x947A,
> +     0x947B,
> +     0x9480,
> +     0x9487,
> +     0x9488,
> +     0x9489,
> +     0x948A,
> +     0x948F,
> +     0x9490,
> +     0x9491,
> +     0x9495,
> +     0x9498,
> +     0x949C,
> +     0x949E,
> +     0x949F,
> +     0x94C0,
> +     0x94C1,
> +     0x94C3,
> +     0x94C4,
> +     0x94C5,
> +     0x94C6,
> +     0x94C7,
> +     0x94C8,
> +     0x94C9,
> +     0x94CB,
> +     0x94CC,
> +     0x94CD,
> +     0x9500,
> +     0x9501,
> +     0x9504,
> +     0x9505,
> +     0x9506,
> +     0x9507,
> +     0x9508,
> +     0x9509,
> +     0x950F,
> +     0x9511,
> +     0x9515,
> +     0x9517,
> +     0x9519,
> +     0x9540,
> +     0x9541,
> +     0x9542,
> +     0x954E,
> +     0x954F,
> +     0x9552,
> +     0x9553,
> +     0x9555,
> +     0x9557,
> +     0x955f,
> +     0x9580,
> +     0x9581,
> +     0x9583,
> +     0x9586,
> +     0x9587,
> +     0x9588,
> +     0x9589,
> +     0x958A,
> +     0x958B,
> +     0x958C,
> +     0x958D,
> +     0x958E,
> +     0x958F,
> +     0x9590,
> +     0x9591,
> +     0x9593,
> +     0x9595,
> +     0x9596,
> +     0x9597,
> +     0x9598,
> +     0x9599,
> +     0x959B,
> +     0x95C0,
> +     0x95C2,
> +     0x95C4,
> +     0x95C5,
> +     0x95C6,
> +     0x95C7,
> +     0x95C9,
> +     0x95CC,
> +     0x95CD,
> +     0x95CE,
> +     0x95CF,
> +     0x9610,
> +     0x9611,
> +     0x9612,
> +     0x9613,
> +     0x9614,
> +     0x9615,
> +     0x9616,
> +     0x9640,
> +     0x9641,
> +     0x9642,
> +     0x9643,
> +     0x9644,
> +     0x9645,
> +     0x9647,
> +     0x9648,
> +     0x9649,
> +     0x964a,
> +     0x964b,
> +     0x964c,
> +     0x964e,
> +     0x964f,
> +     0x9710,
> +     0x9711,
> +     0x9712,
> +     0x9713,
> +     0x9714,
> +     0x9715,
> +     0x9802,
> +     0x9803,
> +     0x9804,
> +     0x9805,
> +     0x9806,
> +     0x9807,
> +     0x9808,
> +     0x9809,
> +     0x980A,
> +     0x9900,
> +     0x9901,
> +     0x9903,
> +     0x9904,
> +     0x9905,
> +     0x9906,
> +     0x9907,
> +     0x9908,
> +     0x9909,
> +     0x990A,
> +     0x990B,
> +     0x990C,
> +     0x990D,
> +     0x990E,
> +     0x990F,
> +     0x9910,
> +     0x9913,
> +     0x9917,
> +     0x9918,
> +     0x9919,
> +     0x9990,
> +     0x9991,
> +     0x9992,
> +     0x9993,
> +     0x9994,
> +     0x9995,
> +     0x9996,
> +     0x9997,
> +     0x9998,
> +     0x9999,
> +     0x999A,
> +     0x999B,
> +     0x999C,
> +     0x999D,
> +     0x99A0,
> +     0x99A2,
> +     0x99A4,
> +};
> +
>   static const struct pci_device_id pciidlist[] =3D {
>   #ifdef  CONFIG_DRM_AMDGPU_SI
>        {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
> @@ -1253,9 +1806,15 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>        struct drm_device *ddev;
>        struct amdgpu_device *adev;
>        unsigned long flags =3D ent->driver_data;
> -     int ret, retry =3D 0;
> +     int ret, retry =3D 0, i;
>        bool supports_atomic =3D false;
>
> +     /* skip devices which are owned by radeon */
> +     for (i =3D 0; i < ARRAY_SIZE(radeon_pciidlist); i++) {
> +             if (radeon_pciidlist[i] =3D=3D pdev->device)
> +                     return -ENODEV;
> +     }
> +
>        if (amdgpu_virtual_display ||
>            amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
>                supports_atomic =3D true;
>

--_000_BL1PR12MB51445F87807DE02B7BA11EF4F7A29BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Fixed locally.&nbsp; Thanks!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 22, 2021 12:41 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 11/66] drm/amdgpu: filter out radeon PCI device =
IDs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 9/21/2021 11:36 PM, Alex Deucher wrote:<br>
&gt; Once we claim all 0x1002 PCI display class devices, we will<br>
&gt; need to filter out devices owned by radeon.<br>
&gt; <br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 561 ++++++++++++=
+++++++++++-<br>
&gt;&nbsp;&nbsp; 1 file changed, 560 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index b6ce53fa9b03..3ab7099a1b16 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -891,6 +891,559 @@ MODULE_PARM_DESC(smu_pptable_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;specify pptable id to =
be used (-1 =3D auto(default) value, 0 =3D use pptable from vbios, &gt; 0 =
=3D soft pptable id)&quot;);<br>
&gt;&nbsp;&nbsp; module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, =
int, 0444);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +static const u16 radeon_pciidlist[] =3D {<br>
<br>
Instead of associating to only radeon, maybe rename to something more <br>
generic such that all device ids in the list will be skipped.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x3150,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x3151,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x3152,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x3154,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x3155,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x3E50,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x3E54,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4136,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4137,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4144,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4145,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4146,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4147,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4148,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4149,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x414A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x414B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4150,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4151,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4152,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4153,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4154,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4155,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4156,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4237,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4242,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4336,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4337,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4437,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4966,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4967,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4A48,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4A49,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4A4A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4A4B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4A4C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4A4D,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4A4E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4A4F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4A50,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4A54,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4B48,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4B49,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4B4A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4B4B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4B4C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4C57,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4C58,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4C59,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4C5A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4C64,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4C66,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4C67,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E44,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E45,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E46,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E47,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E48,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E49,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E4A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E4B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E50,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E51,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E52,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E53,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E54,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x4E56,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5144,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5145,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5146,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5147,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5148,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x514C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x514D,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5157,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5158,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5159,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x515A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x515E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5460,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5462,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5464,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5548,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5549,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x554A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x554B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x554C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x554D,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x554E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x554F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5550,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5551,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5552,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5554,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x564A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x564B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x564F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5652,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5653,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5657,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5834,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5835,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5954,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5955,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5974,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5975,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5960,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5961,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5962,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5964,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5965,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5969,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5a41,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5a42,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5a61,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5a62,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5b60,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5b62,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5b63,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5b64,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5b65,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5c61,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5c63,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5d48,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5d49,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5d4a,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5d4c,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5d4d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5d4e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5d4f,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5d50,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5d52,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5d57,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5e48,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5e4a,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5e4b,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5e4c,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5e4d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x5e4f,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6700,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6701,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6702,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6703,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6704,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6705,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6706,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6707,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6708,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6709,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6718,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6719,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x671c,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x671d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x671f,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6720,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6721,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6722,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6723,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6724,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6725,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6726,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6727,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6728,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6729,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6738,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6739,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x673e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6740,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6741,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6742,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6743,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6744,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6745,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6746,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6747,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6748,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6749,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x674A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6750,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6751,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6758,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6759,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x675B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x675D,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x675F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6760,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6761,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6762,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6763,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6764,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6765,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6766,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6767,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6768,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6770,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6771,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6772,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6778,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6779,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x677B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6840,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6841,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6842,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6843,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6849,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x684C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6850,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6858,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6859,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6880,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6888,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6889,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x688A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x688C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x688D,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6898,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x6899,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x689b,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x689c,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x689d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x689e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68a0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68a1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68a8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68a9,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68b0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68b8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68b9,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68ba,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68be,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68bf,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68c0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68c1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68c7,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68c8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68c9,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68d8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68d9,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68da,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68de,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68e0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68e1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68e4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68e5,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68e8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68e9,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68f1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68f2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68f8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68f9,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68fa,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x68fe,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7100,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7101,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7102,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7103,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7104,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7105,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7106,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7108,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7109,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x710A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x710B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x710C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x710E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x710F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7140,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7141,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7142,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7143,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7144,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7145,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7146,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7147,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7149,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x714A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x714B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x714C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x714D,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x714E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x714F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7151,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7152,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7153,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x715E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x715F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7180,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7181,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7183,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7186,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7187,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7188,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x718A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x718B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x718C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x718D,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x718F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7193,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7196,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x719B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x719F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71C0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71C1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71C2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71C3,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71C4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71C5,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71C6,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71C7,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71CD,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71CE,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71D2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71D4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71D5,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71D6,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71DA,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x71DE,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7200,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7210,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7211,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7240,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7243,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7244,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7245,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7246,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7247,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7248,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7249,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x724A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x724B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x724C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x724D,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x724E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x724F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7280,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7281,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7283,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7284,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7287,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7288,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7289,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x728B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x728C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7290,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7291,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7293,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7297,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7834,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7835,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x791e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x791f,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x793f,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7941,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x7942,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x796c,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x796d,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x796e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x796f,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9400,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9401,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9402,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9403,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9405,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x940A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x940B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x940F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94A0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94A1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94A3,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94B1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94B3,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94B4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94B5,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94B9,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9440,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9441,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9442,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9443,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9444,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9446,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x944A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x944B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x944C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x944E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9450,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9452,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9456,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x945A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x945B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x945E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9460,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9462,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x946A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x946B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x947A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x947B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9480,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9487,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9488,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9489,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x948A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x948F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9490,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9491,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9495,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9498,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x949C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x949E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x949F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94C0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94C1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94C3,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94C4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94C5,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94C6,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94C7,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94C8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94C9,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94CB,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94CC,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x94CD,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9500,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9501,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9504,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9505,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9506,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9507,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9508,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9509,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x950F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9511,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9515,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9517,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9519,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9540,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9541,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9542,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x954E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x954F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9552,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9553,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9555,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9557,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x955f,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9580,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9581,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9583,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9586,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9587,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9588,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9589,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x958A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x958B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x958C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x958D,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x958E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x958F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9590,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9591,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9593,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9595,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9596,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9597,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9598,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9599,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x959B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x95C0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x95C2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x95C4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x95C5,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x95C6,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x95C7,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x95C9,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x95CC,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x95CD,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x95CE,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x95CF,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9610,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9611,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9612,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9613,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9614,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9615,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9616,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9640,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9641,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9642,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9643,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9644,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9645,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9647,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9648,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9649,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x964a,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x964b,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x964c,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x964e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x964f,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9710,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9711,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9712,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9713,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9714,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9715,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9802,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9803,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9804,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9805,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9806,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9807,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9808,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9809,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x980A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9900,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9901,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9903,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9904,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9905,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9906,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9907,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9908,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9909,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x990A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x990B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x990C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x990D,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x990E,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x990F,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9910,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9913,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9917,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9918,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9919,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9990,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9991,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9992,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9993,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9994,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9995,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9996,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9997,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9998,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x9999,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x999A,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x999B,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x999C,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x999D,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x99A0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x99A2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; 0x99A4,<br>
&gt; +};<br>
&gt; +<br>
&gt;&nbsp;&nbsp; static const struct pci_device_id pciidlist[] =3D {<br>
&gt;&nbsp;&nbsp; #ifdef&nbsp; CONFIG_DRM_AMDGPU_SI<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x6780, PCI_ANY_ID,=
 PCI_ANY_ID, 0, 0, CHIP_TAHITI},<br>
&gt; @@ -1253,9 +1806,15 @@ static int amdgpu_pci_probe(struct pci_dev *pde=
v,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags =3D ent-=
&gt;driver_data;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int ret, retry =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret, retry =3D 0, i;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool supports_atomic =3D fal=
se;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* skip devices which are owned by radeon */=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(radeon_pciid=
list); i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (radeon_pciidlist[i] =3D=3D pdev-&gt;device)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_virtual_display |=
|<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdg=
pu_device_asic_has_dc_support(flags &amp; AMD_ASIC_MASK))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; supports_atomic =3D true;<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51445F87807DE02B7BA11EF4F7A29BL1PR12MB5144namp_--
