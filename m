Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE458C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 11:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E0621741
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 11:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XZWafG1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E0621741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE016EA8E;
	Wed, 21 Oct 2020 11:19:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34BB6E104
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 11:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjV2FVXyPdIZf+WMEANh6UF8NNV5cfTcGvJ4OFRu4wf/3NjTMHPj8189v700yzIRbH/JLQATC0ftVIECOSw2op0OAxuEleGNSahKVRCwIwp0XsZ1KjT7uTrnHXcRiKsoyBgcZ1cAHEPN5UsR+vfWao0R2zI9aWzwTwHK85GLUGb21KFq1O33Uh2IpdUmrGUcmcU6gRZmOM2cUcm+cZJvyeY83JmVGThQVwDVI5wrOTOnQ8xoKEBVI4851ZsAL2Efwx4MRbxWkKiI/DHSnFMuLY8bnmJwTnbsDLM42spMzvekc9Q5IljaP+lnSQJjsQldidYhTN1za5vNtydxZj1sMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM3durOH0K7SYPLsP3gGPF9va3EDBQU3UWw+2d0GTnc=;
 b=ZJ4f/XyoOsY4zKcNkFjeadmC40Xtz6Iek4AGzD7TVv81FLmE9ECxzE4iOTg0lLmcpalP4+dPhJdEQp7ykGWLZnvpDinNR+JmTOtrjSrT4OX+iVh+2cteP04NASZneVUzVq5uWOUPPe5sOJh9Wmy0By8ai1hoUDXc9xNe8oglD9d1gHxO5N7NjJ9RtDf9/nDoVsPhWHu0uPDHMfAQj7m8Czn35xcMYGKp6L56nqvpNfJV0XCw9V8JZd7zs90Sl86bLvciI+ju6fhXCiNNos6N0/G8ky042FLXXksLRfyHB94T/3PCSEaZhVUFAZrjxSHbTAA4bTcZDuiTCk6lcMfMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM3durOH0K7SYPLsP3gGPF9va3EDBQU3UWw+2d0GTnc=;
 b=XZWafG1MjeCvxzpfSmPtSKN1a2vFzrfc8oc9r6VTo1CoN8CVivNBplf+YpNwa8ypaP87gxEQKbO7i3T7x6abuuX4ESatPLuUc0e9MVvAm2LOEIAuUuQKnfzklYf0HdF9+B8uJFhI1UFvSD51/dSm8K5zoddAxPuq1Uc7uz0roWQ=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 11:19:52 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826%3]) with mapi id 15.20.3477.029; Wed, 21 Oct 2020
 11:19:52 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: remove the average clock value in sysfs
Thread-Topic: [PATCH] drm/amd/pm: remove the average clock value in sysfs
Thread-Index: AQHWp40pG66jpd1qgkCrqpFstD5eHqmh6PGw
Date: Wed, 21 Oct 2020 11:19:51 +0000
Message-ID: <MWHPR12MB1854DCDCEF3254BA4C776ECCEF1C0@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20201021093249.16119-1-kenneth.feng@amd.com>
In-Reply-To: <20201021093249.16119-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-21T11:19:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=380a7f84-df48-441f-9b6a-0000eb41bd70;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-21T11:19:47Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b6c31d52-daeb-425b-b587-000086fb2c3b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6020ae7-3eaf-4257-afce-08d875b33ae3
x-ms-traffictypediagnostic: MW3PR12MB4426:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB44268B3915175B3D92E738D1EF1C0@MW3PR12MB4426.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6CZgZULL1gvUQudQ2GKIpvziP4LebCMp7X9DWSg0Akk2D65ez9denfTJspQnjtVNqk7DmAndtW5Gjv/PjzxVI12o8xXB6gwmga6S4Jqk6e5JaSGkiMHpg8d/Mu/AqGUcnyncgUs5R58mbFwBnfLQ3y7zsdpmM6xc/aEETNIfjIjsXhl9HApA4mZ6CF4yHJYN9tg8lYQmlZjEacnbScRARDcxBSbnVjy0t8befrCA5kZ5Ee4vPHLC1T5vEyRc8+27AhkCaqlLYQpqJkAwnWwZrZJOAejynCFbscyhg5d9lx8PUxLx/uWGyzUp3X0u06j6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(8936002)(66476007)(5660300002)(4326008)(52536014)(110136005)(71200400001)(2906002)(7696005)(8676002)(316002)(83380400001)(26005)(53546011)(66556008)(9686003)(86362001)(64756008)(55016002)(478600001)(33656002)(66946007)(186003)(6506007)(76116006)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 0OFpvT2dN1KiS6z6AYpMUk0p8gk7ck5FmrmOBkrXF6aUNyOMah53ndfrX+iGlBkrecdThX+SW5DlSSfKvEIjHR65/YRn1CiFgHY9qYl9jPr8vlRWVt7vt8CrFxj9uylHF9ijPoj62S+KNxuF0sbBo5PMw0eF7aqp4w+/8ToRmaxFQaJJIfn7f9KTicLu4r8Cd8V7Q0NRzEkPT1bXeSSeVO7ok/pg8hBxg2Nfndbi2tj43fq3j1lZRsAejDTPUv54Pmz9bsIiaJ0UCceSiSaYwYtZMwsO0JassidQ/xnz0l5EaVwYV/Lut41B0YHYc15S+LcPDmY2xd7RJyoQszT9dA8XVMU1jTSDXdgBGHdhqV+NbSmJbLAZCmLS3IdNCI+Mkr5z7bMel2uP0/vlHPCRPMI+XJuHgm53wZb15PSSLlTN/+nVUIEBCTLxeIx2rnLPCe04COOsJh2AGQuR952EyFobBGBQLQ4HhgwW7yBbuFWLFbCxTf2sWZs7AFQQAE+0Rh7GhZph3Y4bmUaAKKBv3guhFf/KEzMikuJ94+TFYEvQeRcVmLyDkFqkagpIITpbVg16Et3vLGVJrVDtoBf5Qsk6ZzLZLxjaQ54w6Zu3q+Vca+7nvzed/rxu2aEAkgVJ4x7BnRrLH0AXotAl9jlJsw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6020ae7-3eaf-4257-afce-08d875b33ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 11:19:51.9221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUK8RhVxmF4/xqDIwU8tYGjx2nhitgeYEOBv5QCGjqSIT2UAjecpqW2Bx7T5ozO0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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
Sent: Wednesday, October 21, 2020 5:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: remove the average clock value in sysfs

if it's fine-grained clock dpm, remove the average clock value and reflects the real clock.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d2851f8e9c11..fa3842f460fc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -955,12 +955,16 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 			freq_values[1] = cur_value;
 			mark_index = cur_value == freq_values[0] ? 0 :
 				     cur_value == freq_values[2] ? 2 : 1;
-			if (mark_index != 1)
-				freq_values[1] = (freq_values[0] + freq_values[2]) / 2;
 
-			for (i = 0; i < 3; i++) {
+			count = 3;
+			if (mark_index != 1) {
+				count = 2;
+				freq_values[1] = freq_values[2];
+			}
+
+			for (i = 0; i < count; i++) {
 				size += sprintf(buf + size, "%d: %uMhz %s\n", i, freq_values[i],
-						i == mark_index ? "*" : "");
+						cur_value  == freq_values[i] ? "*" : "");
 			}
 
 		}
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
