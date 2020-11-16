Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C93C4742C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 08:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985AC208C7
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 08:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZRfsfLle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985AC208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF2D89D77;
	Mon, 16 Nov 2020 08:38:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B826489D77
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 08:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWKGmrd0ThS7kufMsWasQb2hK0V7P8OhbbsPzLYD+yUnCFYfk8+curp4FBRvE4I7hdJ5b58LQHzrsyCaAezCPMGMFDZZEsQ5FNJARzG/IEt/2Rbw4YefM+U/RPSaeU0nT5K3vC5rbpgyznbpSNVGP978k3Urai6HMi/xOxsmxXIlDN/K5UV49dC8hi2y8ea3j4PnhR0LrhQoZKK8owa2EUn58lx7ymZKY3Rab0lvmun7i6RFpBrIFecbDQE63nebjsCAamtiW/dQQB0ukIvYRfXHd9bMNNWx1N6rhIIAs5j8qOWAnb9Xxl7fchy0X7UDLqsJZ+Uef6DqmD98f1S+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTe9ygNdzwSirF26UUKpzZ6ShCgFAyMQt8gLCQWAD0Q=;
 b=iEQS2YFLlGlZ4np9QwJAsJqEO8DuxuTFCGrzCYB+ZZt00YAQ9//PWlhBWSyLAh8R7vsuw4MQfMPuGXCYaK/g4Kv0lfqx8WDboos7JxJ6FrcPuGZI5SEMy/Uwh827nsTloMHfyJxJYzsOCQZ+gNi4NRVtTvg10cIHmxrM53HUcLbmGQ+sQjdVe7soSEGVjLt57DMhJ0Ob/kFAbBHdlL+d4S9coctRM5f1nM3AU+bcFb51nW6Q4yLRdI9PiaR1mrkIX55rdQTDLkp5pt0hZK2bwgCmzJ0mA+HfX4zmzaTuJ9OJNwbdrjCavZZrgYCALpAynJO4PNtWeSZdzTSQHywOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTe9ygNdzwSirF26UUKpzZ6ShCgFAyMQt8gLCQWAD0Q=;
 b=ZRfsfLleIi2xNyG/5EBeAJfT32hoEBxjmWD/KDdwqH2bl2btFBmsK8rSsxHDUPq4epjaY2GL4LzlYjulwpnNkttpfV+mSUgZKgldhNE6e2zWAZuDZhePPymEK4F/6eSyxS9gH3Edh7l+w9Xg+qMlz5QTqjvfgUdvjsTusFklS3Y=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28; Mon, 16 Nov 2020 08:38:44 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%8]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 08:38:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Thread-Topic: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Thread-Index: AQHWu+d8N19YY1mUSUKv6EhkHXnKfqnKb9nw
Date: Mon, 16 Nov 2020 08:38:44 +0000
Message-ID: <DM6PR12MB4075CA21EDB422457CCAA3DFFCE30@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201116070933.389791-1-likun.gao@amd.com>
In-Reply-To: <20201116070933.389791-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-16T08:38:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=57ee91eb-82bf-4b1a-b460-0000a4957471;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-16T08:38:36Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7a36ebc2-9413-4165-aa7c-000087b3b1ef
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-16T08:38:41Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 5cb09235-664b-4b96-b50b-0000a7424f84
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30abe863-0b23-472f-52e1-08d88a0b071f
x-ms-traffictypediagnostic: DM6PR12MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4959FBE911A4CD91D83DA680FCE30@DM6PR12MB4959.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: njzVvS3q+hdmaRCCQL63oEwZS1FxfNp4mreKLlg6FDPm/1NW/M+AjEM8CJbWeDnIPedOCshYSOqKV2+7FOngeCp5+FBhOfj4rWQRgSuNhvmjLim7o7EnsRysFD9ddNHG6u7596lwy0bZeVD880uWbDVC7dw+DZucbWwNjwh6FxS40tNs4AHN3pfC0ByKVU6RSbcWqJ29tbG9fgXoJXoGr7fSm6JP/1PozeT4KPiPqohZ/ygv9YBgzaqTxpI/VKTn1ZuuPh9gSzI6poCxkogJHsCgsI86ISEmkcXpZ2ODXTcsE8293KaWhhTgSzwZ98tiN1IUdPvJ1og2HUCuK3QFjg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(52536014)(5660300002)(19627235002)(71200400001)(26005)(186003)(86362001)(76116006)(66946007)(64756008)(7696005)(6506007)(66446008)(66476007)(2906002)(33656002)(53546011)(66556008)(15650500001)(55016002)(9686003)(316002)(110136005)(8676002)(478600001)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: NYsAoUUPFoEjhrsZPplGbVATK1SxQxXX5RdLZLV4US4DP6yUZdT/115LYu3dvkH1iZDJdH9e1VfTnsafec/ZCpgK06Bj10nb13HmnLUq/o50ez2fb2rcVn4fytKMgaNKQg/58xC+ZW5A0lqGx6AiK5X/gS1Appwb3VA/dt7fXPUqcjr4BAi5R5ui1iExlp8Z0j8FBf9hlZXbiOKhUKDSZffnTeHL8LFS2kxEtcDflfmb61MNJiyGWYEo8dx0pHiXit0GzRrXvk/JiKZjICe8HpYrCGNrbZmky01TYvh2XWd+enAi26FiJ4FS53Cp1evRBsDZsggGDYqup/mX2omaeCKe98yKkwPTMxn0KgOvNBDjBQUASGFJKINWl6oQYc0YUhuXYYv9aF8Wg1iTHHJJ3eUHsfTYHAOJFF0XTRoKyNQrv8Jza99vjMoY3bq95dzMK1Audmxj+uanVfCScRjCTei1npEDuDREPUYTV/q8eJpnYfQTHBONwJ/9Pklda5T+TBHrHQTZSWhNQ87+rsjUpX7iBNbsZktBFr9INNzVbIn+qcA3a93GrglSYtFks+l9r8zT7KmQOwTcQVHfIwh4qxjNwBI/aUH7vdtZ4MGUL+Rirb/YwLuJX8iAyFqnwOKCpW4Jf0dp0JETvQNE8mzMDiVQdyAc9NPiM25++r7UAzOmUGURv6/5XmptbHoZAReYoScrnoAj/mzXnwMiV9PCXBVAayDgiWrXSmjt8SL4s8BNRGj3YF7zpmF9q6+fNzPSWT2BaAjfk7xSwmasMy4Zq8W/Zft0RRaFYWvZ8PUjjI8gejYmTml7DeG/iK18EtuEJw2qDLHCmf9z3ikRLwUwF5jnI+6tElP4T/S4Ni5xa9xAVitQmlcO5EzsNKAkc+n3ylU3jF+4gMXwydKrFsFjEw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30abe863-0b23-472f-52e1-08d88a0b071f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 08:38:44.0138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wX1qQOVOsp+GwMwn9nGc8Pzi5563u0TOyCZg6JpySI3jRgpNyJDxxZBBuBkmrDR/4gvFBCOJvREqb8qbZ5U1Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Monday, November 16, 2020 15:10
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid

From: Likun Gao <Likun.Gao@amd.com>

Update golden setting for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I968f405a11b640174f5bc03eacc5f4edee47815a
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 270b502f28f2..a6d03931f7fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -155,6 +155,11 @@
 #define mmCGTT_SPI_CS_CLK_CTRL			0x507c
 #define mmCGTT_SPI_CS_CLK_CTRL_BASE_IDX         1
 
+#define mmGCUTCL2_CGTT_CLK_CTRL_Sienna_Cichlid		0x16f3
+#define mmGCUTCL2_CGTT_CLK_CTRL_Sienna_Cichlid_BASE_IDX	0
+#define mmGCVM_L2_CGTT_CLK_CTRL_Sienna_Cichlid          0x15db
+#define mmGCVM_L2_CGTT_CLK_CTRL_Sienna_Cichlid_BASE_IDX	0
+
 MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -3144,6 +3149,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCUTCL2_CGTT_CLK_CTRL_Sienna_Cichlid, 0xff000000, 0xff008080),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCVM_L2_CGTT_CLK_CTRL_Sienna_Cichlid, 0xff000000, 0xff008080),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_PC_CNTL, 0x003fffff, 0x00280400),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
