Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50C1C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 17:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D7820678
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 17:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JmHTcZmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D7820678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB9A89CF8;
	Mon, 13 Apr 2020 17:34:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3121089CF8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 17:34:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzpviCsxRwN5ndFfDu0xSy/Q/U7pg4SlT/sPUk2XzVCxAJbWBSfaVBW8GRgfvdwh2HniCJipvUMshC/Dwkes7tt3yKks4GEK42zbnZkGrp9V54Geakz6pmJp6MnnF0JPrkgFoQq/BCwXzmktNP5SkPCgwfBAAgHKWTwLh2336zv6Y1BZa9hoyaDuDMU3NzHSeyg+FX1cltNinUm7pWTdOJruCAb1exFHEgvXc7BtaED1mkrFaPmmEb3RpRG4m6Udg6XsRjCEawlik4NYW3qrWG/kUvvtw9hTIFqfoEgN9htC54vyhxmYFxc6oPQT0ZTLvaq0mvcvCvXXrsD22ichRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/QpUHbHGBRIL6ifHCcO2jVgXq1A0uhzNQMhlGHnelg=;
 b=Mskmedu1qYgN5VIC71MWdmi/evI0yU6aoynGqToN0IGGHyA7N7Fw3mh0CLSk0M+wRfzKkynMsZ0GB9zsyia9VlTJu7irOkNDK5QydDsGW56mD50dGUxKotMxhl/WCF3iEfUGc7OhPLNyl+rsIgsRPdeZJ0QMn6/ozfrsj6ivoFIt+Sn/UkB0mpqvfFzs2zRZCpdjrAhZF9cS08un0ZvGr+Pa5z70ZScl/bp1mhxlJe0pZ/OMXjVa+6IcOdJoExi05mGeI3gDUaDyTmIjOzm8QHY5j0a7u4Aly3M/bZYVgpAQboEXh90Cm4Zy/VlVnlzsvwctK/QozYDEKWo3XKhTzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/QpUHbHGBRIL6ifHCcO2jVgXq1A0uhzNQMhlGHnelg=;
 b=JmHTcZmGoRtEwarBao75h9SGbqrQAoQTRZnKQ83uCakO2UDAFm9bOOSoJW5jH21uh+T1Mg7/50Ic97UUtyx5KjjqlKf/EMIsjurWAQ8gJDkykeOkeRoEjZuzQVz+z/p10QCYXuy/BcCaX185BxY42ByEY8sntenne+xuD34gDPc=
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32)
 by DM6PR12MB3372.namprd12.prod.outlook.com (2603:10b6:5:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Mon, 13 Apr
 2020 17:34:41 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::d6:29ec:f15c:9b09]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::d6:29ec:f15c:9b09%7]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 17:34:41 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/vcn: add dummy feedback message
Thread-Topic: [PATCH] amdgpu/vcn: add dummy feedback message
Thread-Index: AQHWEbbHNexn97KLf0uPExkcZL6LI6h3T6Aw
Date: Mon, 13 Apr 2020 17:34:40 +0000
Message-ID: <DM6PR12MB3914FA92EBF1EBE5812B8E6CE5DD0@DM6PR12MB3914.namprd12.prod.outlook.com>
References: <1586797955-24224-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1586797955-24224-1-git-send-email-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-13T17:34:38Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0159b04c-f18e-4bbc-aa24-00004440268e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-13T17:34:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 16e380a9-aa7f-4e2f-ba4d-0000c9d8b494
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
x-originating-ip: [2607:fea8:a200:445:4854:37f:25ae:f818]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 975277df-1d60-4488-cbf5-08d7dfd0f272
x-ms-traffictypediagnostic: DM6PR12MB3372:|DM6PR12MB3372:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB337294B669955BF1222F742DE5DD0@DM6PR12MB3372.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(8936002)(86362001)(8676002)(15650500001)(66446008)(66476007)(66946007)(81156014)(66556008)(76116006)(52536014)(64756008)(53546011)(6506007)(71200400001)(498600001)(45080400002)(55016002)(5660300002)(33656002)(2906002)(186003)(966005)(9686003)(7696005)(4326008)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /9PMrGj5XniZsBYIaVyvJPJiaJFan0PYRwXSeNqfVQHmC+XoPuPwbYrp6Rzwz1oNxAh+NLa2o/d7w0tymw9zWcwTQAgz95V8OJBvGqETWQwd3KQDxh6ldLhR4O8OcGiV7IVnA4JiNSQ635hEnMax3Wd13f6DpLYnurVwf/8NNYfXCNbV3TLB6N2QPpOiMemVXHsowIrb5WnEEn7qDXaSYkmzHBizMR/aDCWYJZ8w7kEZ3gfk2NkB8iKMGOncyf5wZqVFAeBogtIrvEAsxXFF1GCgdlY44qlbKKEUd0uZc2OZONNNUhQLWy9gQt0e/g4boCeKdjzP++gFJ2RYNvFbM3t1oxyK3dDKcblSxTHTeX12b8SYNpZnOr94A4i9ARscDdwIag7F6CGXvkcVmJ8s3Iwb7LPrFKxZMAj3l5fXuASV2P9dmx/LmGn7Io9NlA9553TW4jaj9PX2jTTzFBzz8CBg47gRbdE/A/yEB4EvDWY=
x-ms-exchange-antispam-messagedata: ImyYkcaWiU5dC1Pq4JBoemyhOG1Zre8K++BtodEAkLeBcNheBOB2mtxk0hmMHc0gXu0LMDL1F1Uil2EvdH9dyY1YM9i35tU2L0rfFoClBhtEsCZWwH/r7KIHd0me/7Cbh62a7Qcf8jyR4RauIvj53cS6X0x041k+nuYPKR4gJYwOla/wOFSWnkeeG8rHEThyPTBY47m6HaFV/KpEahPolA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975277df-1d60-4488-cbf5-08d7dfd0f272
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 17:34:40.8786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZlPNTIfVww/LcEDrY8GnL+801H/93aAdBQeMFAmGdXBGDAjeAbe7AnlcDbt6SBeu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3372
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
Cc: "Li, Pauline" <Pauline.Li@amd.com>, "Zhu, James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

I think you need to create a MR for libdrm patch, and the tittle should be like "tests/amdgpu/vcn"

Regards,
Leo


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of James Zhu
Sent: Monday, April 13, 2020 1:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Pauline <Pauline.Li@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH] amdgpu/vcn: add dummy feedback message

Latest VCN firmware has feedback header check.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 tests/amdgpu/decode_messages.h | 4 ++++
 tests/amdgpu/vcn_tests.c       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/tests/amdgpu/decode_messages.h b/tests/amdgpu/decode_messages.h index bd6fe4b..0dd80a2 100644
--- a/tests/amdgpu/decode_messages.h
+++ b/tests/amdgpu/decode_messages.h
@@ -845,4 +845,8 @@ static const uint8_t vcn_dec_destroy_msg[] = {
 	0x03,0x00,0x44,0x40,0x00,0x00,0x00,0x00,
 };
 
+static const uint8_t feedback_msg[] = {
+	0x2c,0x00,0x00,0x00,0x2c,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+};
+
 #endif /* _DECODE_MESSAGES_H_ */
diff --git a/tests/amdgpu/vcn_tests.c b/tests/amdgpu/vcn_tests.c index ad438f3..0d8df81 100644
--- a/tests/amdgpu/vcn_tests.c
+++ b/tests/amdgpu/vcn_tests.c
@@ -333,6 +333,7 @@ static void amdgpu_cs_vcn_dec_decode(void)
 			avc_decode_msg, sizeof(avc_decode_msg));
 
 	dec += 4*1024;
+	memcpy(dec, feedback_msg, sizeof(feedback_msg));
 	dec += 4*1024;
 	memcpy(dec, uvd_it_scaling_table, sizeof(uvd_it_scaling_table));
 
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7Ce06ed3031a8e4c5de9d008d7dfcde4e5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637223947784156110&amp;sdata=lkYADqz5Pqcu%2FYN%2BBZKzJHeCV8NypHniPBBHN3WD40U%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
