Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6E0C00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 06:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33F422226
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 06:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0zcjdPpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33F422226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C73F6E03E;
	Mon,  2 Nov 2020 06:42:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D88C36E03E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 06:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juM6vMfd2mWmE+45FufPX8ezRfsFCvQsTtmZUWRllfnVrDH/NgG37042tPgQz92HHnVycSTHB+moWUTz3tW3ZHMlbKvq68lni0WHdi+LivKBXQ9oc1KRufRxEHYSm54WAVBFkFjw2Rv0apcH32al7FWGiSiQOqDndyEthddxmfB1Ed+3zWFv9berWvMkLukrp3N1xI8BhuYFvsQpTQ6RmOiV53Ovs2jKf6SESgTaGDIPVi9gBn3/rivBFNxkbIncLRsru88ZdNLDu+2r4U2gNO3kIyepoJixuMWFFw2liRIykk7y/9iy/8vLy0sCieV7EYqQIZOTjdLjYzMzibh96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+rDstD7CqKa4eIyaeLdISJV6WfgdmS5wjBZm8m3Qi0=;
 b=T3QlGb3MKEHD8Mv2WkimTWtbZeT71aw+SEg2kyx/68KjD8XEYlc21ZPonxF8ato26Socttb2bkh3gOPgjFQy63dS21K1yg8vGzLSU88YP6Wy1dx0PSguXZ9F5xR/9HpvzaA5sYs/NEMEWo3emw5U4UJyHTzpn6kfiWI3OGBbhsR8AUKacSWgQzLU8VB2HVZfuwELyncse8N2IgLfmzmS+RrNqen5USCyLD6dH2GoPGOEY9poX4o8bPMZDMutEz16Om1Tj0sxaVdxZ5UtX8ma48n6NHu+a05Y4mI/T51vT/AndhjfDGfsuSt8OY/XzBYRDwL/XzpKSDIsUOtEGh/3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+rDstD7CqKa4eIyaeLdISJV6WfgdmS5wjBZm8m3Qi0=;
 b=0zcjdPpnYxFPXFRfDdl/6cvpEm4kUueZWYICBSgdNnnYmPhXviinNKMb0SsABkwALAhsUFnT0qIfoF/vjSlgsV4WHPYp46aBozo6gteZyBUILpWx2nq7QOVMwMJ+MS3cZjGD2vTQxtGmNg9vS6WFnhWFJmO6iuvbYSyahdc1bT4=
Received: from DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Mon, 2 Nov 2020 06:42:44 +0000
Received: from DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::3db7:e64:58eb:82f6]) by DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::3db7:e64:58eb:82f6%4]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 06:42:44 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: fix the NULL pointer that missed
 set_disp_pattern_generator callback
Thread-Topic: [PATCH] drm/amd/display: fix the NULL pointer that missed
 set_disp_pattern_generator callback
Thread-Index: AQHWsNTR3KKMhuE6XU2zXMZZNIHOham0ZKOQ
Date: Mon, 2 Nov 2020 06:42:43 +0000
Message-ID: <DM6PR12MB2938D07C8F154548F96A719AFD100@DM6PR12MB2938.namprd12.prod.outlook.com>
References: <20201102045810.2439453-1-ray.huang@amd.com>
In-Reply-To: <20201102045810.2439453-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-02T06:42:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2b4f93b5-212c-4493-b2ba-00009724cb0b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-02T06:42:25Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: dd4379e4-2ca6-41e3-a011-0000bfcf9e8e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02e615c2-708c-416b-ff1a-08d87efa80db
x-ms-traffictypediagnostic: DM5PR12MB1548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1548A0E09DE2717E35B14081FD100@DM5PR12MB1548.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2xsu4usj9FVG5dohDN0Uj3mTGaTNFWSzFqVPef1R/EcdIqQ3kFQGPgKDuOxoCmeze+U+iRqFJwcGnU/rza08w09LEsaXvFbp4nQfdfxa66hN9DTD0lmt0yjKzBUhfnYwMU+nZYnEyXrATt1dAs2AMuoxQkkQWJW/miCsHsUb1oJPqkaVNid7sHuB/mIuPsHNevhxesr7LDl6CiwXiKQqJNjNc/3AZ5OL2K45TxbRkEdI8Z1PGuKzGbObbk6kuCfqI+5F9yGPZR5YZCS/A1Yoy2OXb83/fGfVWXhqd8tgRRZYzA+s8DZxxKb5Pun0T4F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2938.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(186003)(26005)(2906002)(7696005)(6506007)(53546011)(478600001)(52536014)(5660300002)(9686003)(71200400001)(33656002)(66946007)(86362001)(8676002)(8936002)(66556008)(66476007)(54906003)(110136005)(4326008)(64756008)(66446008)(83380400001)(55016002)(76116006)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yfUpf8DO108YFaXZstSVNSQuU5wE2HPa/pTRBwVduRVUnuDuvMgZZcb/pqgq8LZlniusBs4VFiGihCYdPwQtxpk7ef2H09upd+Sd2DpxcfvivY/gd2Xbp9emC5LfcicyVrzGvs/r+QhjMGBpE1YblrgbAth5EJXv+82IGjYt1GLs2lOomYRBs7YZ946fvBvWS2mPgOwRrHym6iBrRnZKGf8CwPlNlCJhqUYVgugMJRCimn5SU8hph4P23eRPtKNDMuw+zmF1yoI3l5eLiZdu/kuOF6yrAvNHW1QsSiRKU/yyQzSB7jho+pjjNaMJVg3Am1DlKJ3xaI7vbOW7pJxNSL/23jBOGjDz63HtWvc1LE8vns7i6qV9zyzQ+6dz0i8njS7LQPB7x4RNhplRuPMwodvITLUPUeH6GEFDgzBU63czDZuaBeFPNKUdACeQ6u13n7LncIfLDbX98JYOZJ4yuFh25ZtDfO8plrAGzxOFhGh0wx6ngp9Tz1oIeIXL8meEEqFwuR0hmu0YbcsUOWzIUppH8/AA+NN4wMTJfOaYrN+xOn4OoqjMx0JJpR/sJstx3cZdjfDBLH/N5TA8G19Ad/C3Pav5lJSrk2Z8VtuUtXShLjrxjx98k7M2Zpw18mQksGYur1bkGlrTZIn8jueP/Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e615c2-708c-416b-ff1a-08d87efa80db
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 06:42:44.0720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9IPujyh+1XQZFMfojhDUzQOcLLz3GlMLHhxy1QgU0mcadiO1ppF6lkmrtO05Eh+X8b+0x9kDhsnnWf2k+sVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Tested-by: Changfeng <Changfeng.Zhu@amd.com>

BR,
Changfeng.

-----Original Message-----
From: Huang, Ray <Ray.Huang@amd.com> 
Sent: Monday, November 2, 2020 12:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Changfeng <Changfeng.Zhu@amd.com>; Li, Roman <Roman.Li@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amd/display: fix the NULL pointer that missed set_disp_pattern_generator callback

This patch is to fix the NULL pointer that missed set_disp_pattern_generator callback on DCN301

[  505.054167] BUG: kernel NULL pointer dereference, address: 0000000000000000 [  505.054176] #PF: supervisor instruction fetch in kernel mode [  505.054181] #PF: error_code(0x0010) - not-present page [  505.054185] PGD 0 P4D 0 [  505.054199] Oops: 0010 [#1] SMP NOPTI
[  505.054211] CPU: 6 PID: 1306 Comm: modprobe Tainted: G        W  OE     5.9.0-rc5-custom #1
[  505.054216] Hardware name: AMD Chachani-VN/Chachani-VN, BIOS WCH0A29N_RAPV16.FD 10/29/2020 [  505.054225] RIP: 0010:0x0 [  505.054234] Code: Bad RIP value.
[  505.054239] RSP: 0018:ffffb88541c66f60 EFLAGS: 00010206 [  505.054245] RAX: 0000000000000000 RBX: ffff912836070000 RCX: 0000000000000003 [  505.054248] RDX: 000000000000000c RSI: ffff9128365001e8 RDI: ffff912836070000 [  505.054252] RBP: ffffb88541c66fd8 R08: 0000000000000002 R09: ffffb88541c66fa2 [  505.054265] R10: 0000000000009580 R11: 0000000000000008 R12: ffff9128365001e8 [  505.054272] R13: 000000000000000c R14: 0000000000000438 R15: ffff9128a48bd000 [  505.054279] FS:  00007f09f999f540(0000) GS:ffff9128b3f80000(0000) knlGS:0000000000000000 [  505.054284] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [  505.054288] CR2: ffffffffffffffd6 CR3: 00000002db98c000 CR4: 0000000000350ee0 [  505.054291] Call Trace:
[  505.055024]  dcn20_blank_pixel_data+0x148/0x260 [amdgpu] [  505.055730]  dcn20_enable_stream_timing+0x381/0x47c [amdgpu] [  505.056641]  dce110_apply_ctx_to_hw+0x337/0x577 [amdgpu] [  505.056667]  ? put_object+0x2f/0x40 [  505.057329]  dc_commit_state+0x4b3/0x9d0 [amdgpu] [  505.058030]  amdgpu_dm_atomic_commit_tail+0x405/0x1ec6 [amdgpu] [  505.058053]  ? update_stack_state+0x103/0x170 [  505.058071]  ? __module_text_address+0x12/0x60

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index 6d9587c39efd..bdad72140cbc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -97,6 +97,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
+	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
