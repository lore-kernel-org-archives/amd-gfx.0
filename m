Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118B3C678D5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 14:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE5E10E275;
	Tue,  7 Mar 2023 14:09:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9DE510E275
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 14:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RU9ENR4r0KCMXxHw3j3CAir7ZAfKlVNvspytB9djgn2xj7Nm6j8+ADv4OVPFOKIfpAZ4mz3FkeBHFgIijWZTKpuQnf0bFe+H7nHxk9jylV9gQVYbCSd2ybwZG1N5Cuj5Erme7RCKDB2XWoRwTWP3tr69hYoxnOiL8zuKwSHbkPVT/ghJ9wyjfmcoGFj+A9/IOktQ8gayzRgjQUllRiEhtHmr+c5jfHm+v7EPP+PdeoS07FYZ/iY5YO55RZ1ae9miIqnjMyqRSrWzNdH6FYNL00K3ujGwzlLCkuSDYBHSiWK2MDCpAgYsxi2DTYz0Q9SCrnF17auOaHiP79rWo5vdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyCedehhu+sq2sDg3LPlUQy5b2IeryHd4FjSTdP4Nnk=;
 b=Bgah78TZ2nXes7QVpWVUo9DDl0LhVhM4ddq+9kUG5vYswalIuo8rjF5S1AuN7x4rBBE+6ffs3TpO3Ad78fSPYqXAfLt5M7fkyUs/clmq/UBqlARCj1smfwVGA2fqsa2YEUo2SXD4L7bXl0KXd1EkbIap/KntGV3BgZdbBg5aiV1HCHBqtMn+cs0+oYt3MF5dASeHbl9UjamAVc2KAiGniSRYbxRnOYdCFfxTcgGXXQAffWnWvp3OKtIzj5e6aE8zMOcytuprFFkhLfLmG9EtN5blpeISV5qpjQ9yaC2h1h7YqY7dcSRpUzkzi1rZ0pcR6sd+q1CvUhf81XKS+gG4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyCedehhu+sq2sDg3LPlUQy5b2IeryHd4FjSTdP4Nnk=;
 b=Ya5mZsz9L0MMRq2FZuMgqltt/p6e8u/HT9u+911Hou9ukS8cI1b4KsoNcSes0O0xJN96VlyqS6KN2LrnKReBCsvGDMCY001dmrfnMMk4d4P/ld9UrEebjDzYHSkSgXnrrCVAsVM/hsVh2XelqqYcBnbOoxurYmJWVUtlUGRe6sQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB5023.namprd12.prod.outlook.com (2603:10b6:5:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 14:09:11 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::ffe7:2ff1:c01d:6070]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::ffe7:2ff1:c01d:6070%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 14:09:11 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix error checking in
 amdgpu_read_mm_registers for nv
Thread-Topic: [PATCH] drm/amdgpu: fix error checking in
 amdgpu_read_mm_registers for nv
Thread-Index: AQHZUP1wlLpujg+obk+JSzl6Lx1Co67vWrDQ
Date: Tue, 7 Mar 2023 14:09:10 +0000
Message-ID: <BN9PR12MB52578AC21E89E26E003E1D58FCB79@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230307140157.912755-1-alexander.deucher@amd.com>
In-Reply-To: <20230307140157.912755-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB5023:EE_
x-ms-office365-filtering-correlation-id: 3e4e7f75-61eb-4907-1347-08db1f158643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzi6AWKVFJFlKDyzXDpHdtFyp7TArKDG+vRqd/6UcnKsqr9aPjRnt9Vy4V1YtVN7nqYckf5kryGhUxT0fUiax1NZiO/DmYwRdeceMlfkzysQLuAj3yE9clvSCMsQtZQK+VdZ/OHpohQmHh6wjwFfHGtvKr/gle8DTdJOjdzEy2lEdQY9bF24ue2fJFkSiWNITN0UutrUFHtR2CKPKQ4fDJ3/wZNOGP6TKmHb8jP9yKf1lKIY+DXFDbUkQwnga0S38Fg7TkL3he35ritkGaW2zoVJtvqguS4NezKBeOGzVOuWCxxejc/eqHaO/AE8nYKAnQTQBe5A40xnLQ09Dzkt3TIZviQiMFi8iTRfmB+EYaGNTVB9R6r0X7F01f/NzEEcfvowzwEgsiGsmGpsfdgkC0f+LLDR+QoaHpqwxfDgcNwTsnqtdEkSM2ZE3Jibru66oI5GCMNEQWjpqruAhB838qRLdCNhwI1YrGeVlfmA8INGB2+R0X5rDbhRhkuPHrHzFUcIPhWYwPypzf24WVev1pcBKshpOIcVguhVDTWDSpjHduLbx5rz45gZs4VkrU5WyuvFZ79MyWOz1qU5K+mGem7pdeW5K4kGZAS+iW6KX7ZVN4R0ohGGdxGS/hDHx8/ppiV5IpBx6GtNa33aPeMp07GDOOX9+mW+K8447rDKVuF4fgw/bYQkoW+0m51zVmN20R2LWIxhaoNv+bLWk9Bv6A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(84040400005)(451199018)(38100700002)(122000001)(33656002)(86362001)(38070700005)(5660300002)(2906002)(4326008)(76116006)(66446008)(8676002)(41300700001)(8936002)(66946007)(66556008)(66476007)(64756008)(52536014)(53546011)(9686003)(186003)(83380400001)(316002)(110136005)(478600001)(55016003)(7696005)(6506007)(71200400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rTayO8xAMqxFQQjv7rml6rJ8YSlDBfNXLTFk+iQMSL0YVu85SsSlVOVWBMnb?=
 =?us-ascii?Q?a4MyLzia315sopIRMiogSY83hDuUbYvuTgSAGjlyRTE9UP/chfq6HSS5X7av?=
 =?us-ascii?Q?cgQ4AfhdJvQgZKhTE/08UjypyJZ+FQxVcH4yMSy9FFd2CK9p4LzAvilN5KGK?=
 =?us-ascii?Q?tCp0gyBSx4vxOUdInM2W9QNaSaQ2NgVeUDq4NcJwipyszwNQHpum2qdYKJ6/?=
 =?us-ascii?Q?nPAH/2dildmYW7qopXilQiCeK0SUKUL0ANXO+f0QBi7jMac6pvlV5t4g2FLA?=
 =?us-ascii?Q?eqJbvl6ss6Ji0XA4rCVJIUROxoyeKyxMMLqp14dkAy6GPI15YR40lyCmmNYk?=
 =?us-ascii?Q?syqd/iVpd1kVQnXVY6J8L4M9KxtD2exjhFXycXygcrMt0/DTwhcUrAgmVa9w?=
 =?us-ascii?Q?DhmDI9XhRSR0LjCPZm9q0k1dGjWN8Fx/Foxc00BNFMoICSSwziXMnJRoC5Jw?=
 =?us-ascii?Q?UWv/wA6ttODA58q3GXbkrtB1czAnS0q5Le8E7tZfZgdkQwoJzLOVxu3ykpCz?=
 =?us-ascii?Q?uWBCAsfiem8VuYwfosUyxS4fHvm0lnCgM4R4Zuq355gAAgxqmF8Z92HRfXMa?=
 =?us-ascii?Q?KoboMOU43MdHGAUdphfPTxwlycRwTORQLkId8PXqDFBJc1CILAme3RogK5b3?=
 =?us-ascii?Q?2ZCw0qwOMGez8glzzeKLfgs8NGQ9JjHdLN/QBTuBJ4kq3Hi95h2hFwZqkV5B?=
 =?us-ascii?Q?U5bZDPKslHx10Z0k67QxYSAHK9qdQJWE9IiXN8TIjZ8XhaitbaUc4LtCm9Cp?=
 =?us-ascii?Q?3Zlq96c6Z3ZhvlOG+Pwd8dsAV+CqEXvWyoPoMmcSINS6268hkas+7rnZxfx+?=
 =?us-ascii?Q?+7FOo/K7pzXRSmTRMFfg+qbTeXw2DceukRhhY8Ppc3NHCnn6AauQRnhOykcP?=
 =?us-ascii?Q?Gjlw9xc+zSnexP0aAyLbDuknMPkqRUbGissbdg61rtihYoZ0aPkPqFocBWD5?=
 =?us-ascii?Q?dj4rIBR2dGasBpLFfJPsk+6o8IQJtUDduPNSrbrwOnBzTc9HISNyTB6hL5oF?=
 =?us-ascii?Q?G1AugzOfflQUf38ahbmYdcr/2cSnsmOz8vGQFjXPL5wqkgdC64FyfjTxRSGA?=
 =?us-ascii?Q?xYw3jYA/j0RaZz9YXvE4IlBNBDtZPzOBiCOrak1LW15KHgAfIxH8gQrVRnwS?=
 =?us-ascii?Q?NlF3ThzHeEJCbzQ/OsDkhtCoSMjGLBW1/yHG1s21NaUDyjYbBWSsNmQ7RaeQ?=
 =?us-ascii?Q?GUj8vyU5kGBWxLgWILG/MdWnl2/xSsAKQGaQwcyloO84Io6dP0mlvO51n+Px?=
 =?us-ascii?Q?nGAdtFkww115BTk7xdC1uj9V2gFWeOqG8fVCI2DffJtp7i5u7KDA89ytVjsK?=
 =?us-ascii?Q?hLLEKVnLiDwMFHv1aI+BQXnSjXAVekrib/EC9juwMUJwYpFNix7GI225c4fC?=
 =?us-ascii?Q?/japkR7Kh4IxLJpl96/IZF6bkpCqlPsKY9gJqsFDDP3am9gg5Sjwgyw9LW65?=
 =?us-ascii?Q?TIdjtYD2+/+5r7cd7kXeepwBPjXCuAJrcMWHVl5bhmwo4f9xE+3G6AmLuoOG?=
 =?us-ascii?Q?XLrPCArQJcVI8tlelhrzMnbTARsdeVeDao+J104yvP61CcJH2wUXCmlm9Xy8?=
 =?us-ascii?Q?XlHbuTUOAcJoAiwf6IZzWe8JPIqV70VbLSDRWrTY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4e7f75-61eb-4907-1347-08db1f158643
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 14:09:10.9749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zf3P+390qYSZ5edChalIAtUyCZp6vtN1yvp/2NucYZtCI0Rdh+GS3k50oJhT3ukgcn9rQR1GTz8dmOrX0oT7YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5023
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, March 7, 2023 22:02
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix error checking in amdgpu_read_mm_registers=
 for nv

Properly skip non-existent registers as well.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index d972025f0d20..855d390c41de 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -444,9 +444,10 @@ static int nv_read_register(struct amdgpu_device *adev=
, u32 se_num,
 	*value =3D 0;
 	for (i =3D 0; i < ARRAY_SIZE(nv_allowed_read_registers); i++) {
 		en =3D &nv_allowed_read_registers[i];
-		if (adev->reg_offset[en->hwip][en->inst] &&
-		    reg_offset !=3D (adev->reg_offset[en->hwip][en->inst][en->seg]
-				   + en->reg_offset))
+		if (!adev->reg_offset[en->hwip][en->inst])
+			continue;
+		else if (reg_offset !=3D (adev->reg_offset[en->hwip][en->inst][en->seg]
+					+ en->reg_offset))
 			continue;
=20
 		*value =3D nv_get_register_value(adev,
--
2.39.2

