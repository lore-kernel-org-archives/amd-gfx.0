Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F44C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 06:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75626221FC
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 06:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jAQBV2sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75626221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A306E96B;
	Wed, 21 Oct 2020 06:50:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805D06E96B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 06:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUT1LW9k1XH8MYTSKxt5pniNx6F0vVsPsEVszXUt9d7BzA/vZawThkBCzbI3SPukU8FQ/baPUl/4iwdnGUP5Q+Cv3NglfXI8Bnym7QomagnDB9Ju548PeC0SKhY5Nq0yqi1CoqKlLtpCMa2ZUf9fmzj0YZCDs/sKW47N5rw0K3hyGbQVcnjO9Xdiv7ipnfOyJrwJ4wqGXWA6FC0buTmDTmH0Wa4pKU7MtRksVeuChmusAzOzKFpac+zedfx32MjAL8G5FdSI5db9CmSbwMoUxbyvhR0awDJ/ct83scIbU5A4X0Ncz97vnIziC6aQeubO2Ng4p6PCiO0q7z6vFZHJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4ObKIvHO9XObwsFbpWqLT68KwvRwagjeFDKXFtIQ20=;
 b=c0lPMpPMie0Z9Ip0ae/rv0nWnYCD+Og+NSgfjCdpSDqNhr5TZ6vXOAIcO5hDhpRmM5S6JXm8MkP82Pucq8LS3WB3DBS2SxPTEpvkFUYM+7we9d7xIm3otln2NJ+CP8AIQzG207JfQigthyHpUZb1QajaAmcWi3en4vnNB1FoOVtrAz/uM8g7TrPqQhjRkkXme653Xa6/20UInksxADXGRuYvglEjttMBWX/EstO0sk1MLe/W+8krIr62VHPhWL4a8HH9H83s88EzJRshSN1fJVdRWb5bYMNfWduS51vPe/a7uks/3kg3+mP4SdPJqLuJ/HCjXR2ubg30zxlNdj6nlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4ObKIvHO9XObwsFbpWqLT68KwvRwagjeFDKXFtIQ20=;
 b=jAQBV2syATHgsSJoAALzigHL2a3z5c5JV9kpk64OBRfewKXODuICWj++/x+F+Sce5+sbfAtzNiB+vysXAdqb4FYKbJK4+jUfCXRtn+te7rRvYmuej5Hce9bJjDym0MR0Ye9FPMdjprEOMUw1M62GXafcjG/AxSMZoLIffAfp43o=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1598.namprd12.prod.outlook.com (2603:10b6:301:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 06:50:30 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826%3]) with mapi id 15.20.3477.029; Wed, 21 Oct 2020
 06:50:30 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Topic: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Index: AQHWp3W2gHbVlGY6P0+C3JMCf5x566mhnbLQ
Date: Wed, 21 Oct 2020 06:50:30 +0000
Message-ID: <MWHPR12MB185444482558FD6456A1AA25EF1C0@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20201021064455.14935-1-kenneth.feng@amd.com>
In-Reply-To: <20201021064455.14935-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-21T06:49:53Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=23ea9b2b-ee64-433e-82bb-0000069c57a2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-21T06:50:18Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 00b572aa-cfcc-4322-93ba-0000b2f0c955
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61204c3a-8c5e-449d-8de7-08d8758d99df
x-ms-traffictypediagnostic: MWHPR12MB1598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB159877C149627C0A54749CC6EF1C0@MWHPR12MB1598.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a4w8F6+qrwOSbaJR9q17L9ALEtxFuIl3+PkUzD+vffy5xFVWtHKKBoOpn1HzZPImR7+n7+cs6Mq8nBi+aoQMVK2+SUi4tfeGM3K6TIn4hmm/dUgik10gujqmYuEggBxPMpyOfcZbS7GBBznTTM1ddxqRbyrUPmM2g1v28l9mArPVEMKdAy3ffP/Y5M87idhIgyhYBYMdNyDO1uM4IR3xV0IJfkkf6C26cA0Z4SSb8JIDtIKARLh3gNG+hXRvJ3J23NymIqkXya8W6IHlvhEhIg42CAYMgVwJg8PjMVgf7JphLxV1o4ZnbFhGDO4Ze9L7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(8936002)(4326008)(52536014)(26005)(110136005)(66476007)(316002)(66946007)(7696005)(6506007)(66556008)(53546011)(5660300002)(76116006)(66446008)(64756008)(186003)(55016002)(83380400001)(8676002)(71200400001)(33656002)(9686003)(2906002)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4JosiTlhuJytY3kfV+vPRqfOshxrxNLqZlkapVcO9+IruReAoWH8OK5p2teqPiRvEhv62RqhzGvfXdaddRVupMn9EWITr4HPUrTpeNM54Mnqn3Lma7jSMYAE22hivnIbj10RJA2ELrLh+DFULtBLsVmLq5tBtWf5Xv9XxFkISciKBFSqT/7yEfeBfH4myxa08DwkoKDHeUyjj5uXHYPLnJEjhpdm69OwLyWutojPgC93KwhX9XS+gplO1p62Tckpg1TwPOxUKPqq2ug+QuamZv4PnkK/brQ/g31te0Wcdb/9S1crshvmtGNt6EPUtKMZ7YHf1EuTZBws9yFgPYVJH5vVxDkPemucO3+oNCwLrZMJnsPFUEcM4o62zCFz/jaE75PceTVDJTItJm2gXZbVqkuhLCnKAy9trktb2foWhzJBpvv4HIgnJcXpshhoNPfZLcLDP6sCyv+sCs2lYt2w0sVFQ/WR+V2L1MihWCFxD94beGuGu5X7taQx66GUMBkw4Ce4ijk91ZOqjM6gY/vYnJn+2AL1RFrfALCgITkcMe491c1ScpKTnazl4f7naHG/HUyh+uIWQ6tHeO4Eak8e1bNlE/f0PYo/6EWoYRzhE7kxVuFuUC7/gcjdkrkAURyFxB0qsgUlJvxwfX1lYkNHrg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61204c3a-8c5e-449d-8de7-08d8758d99df
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 06:50:30.3749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+b+wmBdH8OzspZhhzsh/05Su0/gAFgbaMbgx8uNqOdhX5/Wk3ZEmMUM394oT3DT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1598
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Likun Gao <Likun.Gao@amd.com>

Regards,
Likun

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com> 
Sent: Wednesday, October 21, 2020 2:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input

fix the wrong fan speed in fan1_input when the fan control mode is manual.
the fan speed value is not correct when we set manual mode to fan1_enalbe - 1.
since the fan speed in the metrics table always reflects the real fan speed,we can fetch the fan speed for both auto and manual mode.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 496abc31b07e..27b6cade9ade 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1171,14 +1171,9 @@ static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
 	if (!speed)
 		return -EINVAL;
 
-	switch (smu_v11_0_get_fan_control_mode(smu)) {
-	case AMD_FAN_CTRL_AUTO:
-		return sienna_cichlid_get_smu_metrics_data(smu,
-							   METRICS_CURR_FANSPEED,
-							   speed);
-	default:
-		return smu_v11_0_get_fan_speed_rpm(smu, speed);
-	}
+	return sienna_cichlid_get_smu_metrics_data(smu,
+						METRICS_CURR_FANSPEED,
+						speed);
 }
 
 static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
