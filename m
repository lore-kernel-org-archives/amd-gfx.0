Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8CAC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 08:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E68A20678
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 08:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s8+Acbyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E68A20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077AB6EA05;
	Wed, 26 Aug 2020 08:16:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D626EA05
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 08:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jf4C4oa/FZwO7nrFoZuzqMrMRH6g7kEOI9T6l0xFLmF7ibPtfWKzNS2jcN9Aog9IzhNEZOHTmoHLl9jmmgg5bs4buwSDFzAiNtkLSzH9Q8fApqW8DuFiu244+V1xYH13211I9b5/fn6hrWuUkwzrpjsYOLfoSLZzASDpO9iNIGLxzhNp6dRkncXbKjH0w+A/T9OCGX3wdYkCxXM/lUWJ0/kP3wCGDEVjUbrHm/RuT2RC8zCMD1+/Twg4rg+ItIljV7lnOpzeIpDtx+ap7jxdQoz7C9RPQ7gHzh92ga0pR2csHMBHbbhVJ3v6+T0J4MjUU/aUjz+l3VCf/ORl5YZ+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2Wt0AQeZnI6Bbsb4k/YnMczV/745yDoAXkKGgkXxLQ=;
 b=VpQsxQry6APcVFLEb63ZnHaeK862XSeABmEP5H48q4EDlDemI043XjWJ9jyBhd06NLe/XvF0EqJp2Uj3xQMRwDzPpp5LwK5B2K+78ZSAs2YQO5S2sCjwux9EjVGTkfDyafm1wHz1uYDGnpyUZnIs9JHrheIOT7Pxyig5SHfr3LVZ5B1h7je7tNgEiCbfz270QPan63d9jDlGz2MMKI/CCXZgPudp1Rd0Id68vmffgQF5nomAA2JXIs1ReE/4BaMRXSMblgmbEfZ/x0i9r3dMHGAnN6IOiJyTZkQN9SHVyURws7xmTDvUPg2t/UGmL8Lh1thw+Z6ishJ54ai1AfVjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2Wt0AQeZnI6Bbsb4k/YnMczV/745yDoAXkKGgkXxLQ=;
 b=s8+AcbynMmO7ur6YiYmZ4lQRj0yrBCwI+Ezzmb1Qp2xA2wpSF4iRSXfAM+4tkhhlUv8hHTJA/IX+GTuqYooO14yqYHrtAfbNs3FJ2FPimlh4MZHUxvofA2sxVaNs1+2pOOpQRuErDmH/ymRc7YUwlQV96BGmUhLcT+TBv0/i6yE=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR1201MB0233.namprd12.prod.outlook.com (2603:10b6:4:55::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Wed, 26 Aug 2020 08:16:43 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 08:16:43 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct SE number for arcturus gfx ras
Thread-Topic: [PATCH] drm/amdgpu: correct SE number for arcturus gfx ras
Thread-Index: AQHWe33wR6q1Mgh0WkCvYzRhLOmI16lKC1Jg
Date: Wed, 26 Aug 2020 08:16:43 +0000
Message-ID: <DM5PR12MB25337F42471DE18E54741FEAED540@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200826075236.28735-1-guchun.chen@amd.com>
In-Reply-To: <20200826075236.28735-1-guchun.chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-26T08:16:37Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=70e9a4e8-4a8d-447c-964d-f7a4fb58f4be;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41150bb5-b98b-43a2-2f35-08d849985e15
x-ms-traffictypediagnostic: DM5PR1201MB0233:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0233CC3E2D37483295717118ED540@DM5PR1201MB0233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0yh7jQeXGA0NMcnXcifEb+3UE77F5Sebc5t2+JaVQeQfRQ3Lh+BMYKU7xSRr3iX9/ee9I7B6qopCkzi7l8BIEdxgU+o9tqHBxRjjt2HQpJ1VOOcFq1bIx7F8l27Dgpr/uudleDKuf+l6V2o7LIm6wTY0Uhnkaw1qV54nFzku+3+WkAhSzlpjUnht5iokeXcHtIQ5Xxn2Vp/tfaFQG77w6Z6BAQKjkPaVGSbYoYQWqbhHn2rDKxVM6ZxCvgCW8H1E650frCMigushrCJsIHYQRAIndhie1S5Js1Q6Sg7ezXgPTp9OBgULcFmez6K0ftey
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(71200400001)(53546011)(6506007)(6636002)(9686003)(26005)(186003)(7696005)(478600001)(8936002)(2906002)(76116006)(66946007)(83380400001)(66556008)(110136005)(86362001)(8676002)(52536014)(64756008)(66476007)(33656002)(5660300002)(316002)(55016002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ocFvZo3rkxRtM1UYE1y3XfVwnmpHe5HZYMGkiZhaN9Qz35DLEKeAk5T7FcBRtLoaQTMQ/L8Cr7WO6skk7tj8AT5qQQxO5Av4Iv8R421W8FFeHQmnLVl8ncqI2QlOByWmqWjYT44UY/qOXmWIDt1tptZCEnwNshKijUZhq3WdfTkId6iTG9QAE5KQgZ4BY1mHtof1OuenfS50/Inlfn8/fZwUqB2/T1fgXZfPJ+/JoJeFdfOGqFj2HCvQBhsK/rDtv2WZdbfPucI21VdTjpYm7DnMeU/KQHA49VpSnhWnPIlK4fzhGsKF8cDq1lnevXnzUU+s4AfWRlCuQWOUj1Q5HYBJ6J6KeDNG5hpkzzYWS79qFwdayG/SE6o7zxZHryYXwrjBoPf5EkZx+mxNdm2/RJjKqeGhf2N3Oib+y5zlhaSikP4FNlqsWV3+USSRNMNFRG1WDt5ghsKlSv+G72j0RapIpebw0SJYEWbhVoOvmS5+y49KJzbRX5XH9EeGYSBf4MTznc/hJe56NFeuQOmNzSxBA6B7Uzf0pQiA0VR4X8KhpuofobwDqmQECNXfiC5BrX+HpHGF+mcozPyaVem+7H63B4fpiJALj1T2VMKF90EBzVxSY8cTU1JuCkZFtSXgoFRLRDaKqyPyk3JKe5jZxw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41150bb5-b98b-43a2-2f35-08d849985e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 08:16:43.4698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKknZm4/3Xgf1hu0UVkTxp7C5T/LyUQh+Gq6alhdpfp40CAIt7EEp6FKtMXOSifv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0233
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]


Reviewed-by: Dennis Li <Dennis.Li@amd.com>

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Wednesday, August 26, 2020 3:53 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: correct SE number for arcturus gfx ras

Arcturus GFX has 8 SEs and 16 CUs per SE, so when resetting EDC related register, all CUs needs to be visited, otherwise, garbage data from EDC regisger of missed SEs would present.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index 46351db36922..bd85aed3523a 100755
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -57,10 +57,10 @@ static const struct soc15_reg_entry gfx_v9_4_edc_counter_regs[] = {
 	/* SPI */
 	{ SOC15_REG_ENTRY(GC, 0, mmSPI_EDC_CNT), 0, 4, 1 },
 	/* SQ */
-	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_CNT), 0, 4, 16 },
-	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_DED_CNT), 0, 4, 16 },
-	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_INFO), 0, 4, 16 },
-	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_SEC_CNT), 0, 4, 16 },
+	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_CNT), 0, 8, 16 },
+	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_DED_CNT), 0, 8, 16 },
+	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_INFO), 0, 8, 16 },
+	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_SEC_CNT), 0, 8, 16 },
 	/* SQC */
 	{ SOC15_REG_ENTRY(GC, 0, mmSQC_EDC_CNT), 0, 4, 6 },
 	{ SOC15_REG_ENTRY(GC, 0, mmSQC_EDC_CNT2), 0, 4, 6 },
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
