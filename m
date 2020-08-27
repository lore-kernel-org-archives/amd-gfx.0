Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9615C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 06:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966DF207BC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 06:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PLg6idqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966DF207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44AB46E43B;
	Thu, 27 Aug 2020 06:50:41 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700044.outbound.protection.outlook.com [40.107.70.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D506E43B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 06:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzgeFN/hFCBLLatoPXG31gKdEo/A6hNSsWGhseM6rB+OrJma/Trgg2ofQRo2kGNtQM0XoBL1vnDQFLnlmSObPv2mBD5OeVb8rXV6KCG0gx4CHnoBvCtghNJ7OmiyLM03tNmgtF5ocI3HOmVOl451LTYhPrMGppN6wA18n834HDsX81UXe/TT4pJhLd5SrnXeZxazq/eTDI3Qjhi8L9nOio1IulvtJPsGKTln8c1+gdj4cqN0H0BJZAy2VbGF+ZDwVdnh2y4zbpDjcfBvNMlemeWmQUX9WkRjG6K+YrWsrxpJW2xq+LjkTgWhVnWJYJX7a0qOULs44ekqUP+Dp/uf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDfE3I+9fNSYS1i7W3E3LREx6+u5PPmKHl9suvB71qo=;
 b=ZOE00hbrXnwhmgrDfyBNIVvjzjQtfDUnyzfvYTw5N54ibG9vfrcNOe4GgtAcc6eUo8ogJL6kDNOvrUbEYH+ZH7+IZYF/FcN3YN+sRYMtd+lZVyxlbJEAnhrx/0PZiuM13UaEhAdz01n2UEWxfzCrfdOzAerpISOeC9fIXWXI3f1nyj3vmTUF19rnvYfvnDTKZ3q+8LKrunIsZ44BVNFiIFE4VuMSTOdk2gW58NrfE/yjgUVfviX7M3ptBnkLBnYrlOk5bkYNI22NvJ6DWfpxf9+PtcBoCyQv4oa4KfW6Lhi7z2xjDwXMVii8zb9bF7v1hxnBTfP4QLCmokOWCRSdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDfE3I+9fNSYS1i7W3E3LREx6+u5PPmKHl9suvB71qo=;
 b=PLg6idqeQnCOaKKQjS4OOTynEQOtSH4Y5FwjsU2UU6/DSw8j3O8GQ25Q9vKcpT4SzF59dMQww+1O2SbK8t01ltPPW0Gp8Hvret9Su7ut4NC55vYDyGH4F2WPYxOgMpb6aPPWpLZmk9CVczepXhVhvlkLPUvTOr4wT83Vf7UlKCY=
Received: from DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20)
 by DM6PR12MB3033.namprd12.prod.outlook.com (2603:10b6:5:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 06:50:29 +0000
Received: from DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::c4db:d26e:cf5f:ac68]) by DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::c4db:d26e:cf5f:ac68%4]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 06:50:29 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: simplify hw status clear/set logic
Thread-Topic: [PATCH] drm/amdgpu: simplify hw status clear/set logic
Thread-Index: AQHWfBpMdSCDzJ9UzEq8A7pqjTRQf6lLhD1A
Date: Thu, 27 Aug 2020 06:50:29 +0000
Message-ID: <DM6PR12MB417014368B684A34A3C99520F8550@DM6PR12MB4170.namprd12.prod.outlook.com>
References: <20200827023219.6650-1-Jiawei.Gu@amd.com>
In-Reply-To: <20200827023219.6650-1-Jiawei.Gu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-27T06:50:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=724a8b40-6d1b-41ba-be1a-00003b5b51ba;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-27T06:50:01Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 99b0b498-4e58-4754-a984-000025be7b46
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd1cef17-f554-4556-0a54-08d84a557cbb
x-ms-traffictypediagnostic: DM6PR12MB3033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3033AF05E958FBD53BFB3775F8550@DM6PR12MB3033.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:309;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5gbPf4SreDEtF3Kj5zNirdhSZJyJWOwCkdVxXKBAz0HTAjNjbbRjLGUMMR/8zI2rC9VEIulLaikWTP5INYPo/qbsto9xOJM5oqWcMvDeaSe1/1rhnu7J0feiT9TVLW5XDSK8UHqdVtIMWps8Qbtzp+saKNcmhP5UBbZOov3miOFAIWc0dSWBTyHK4ZBz/2Edd3XGMeVKU+1Kb6HE3ibbFiAoJJbVrabLW+h31hbLKdfMNjd2lKI9vbyEy+FMXXKAYzXhw/pwcLuWycm9vt6RZd0+pMtFvdA1MSo2D/xKYtSAeetT2WImtxgHl975o5fMYEjgfms/fm2ljxrqJAj1IA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(55016002)(53546011)(186003)(6506007)(316002)(9686003)(2906002)(26005)(8936002)(6916009)(71200400001)(8676002)(5660300002)(4326008)(7696005)(66946007)(66446008)(76116006)(64756008)(478600001)(83380400001)(86362001)(66556008)(33656002)(66476007)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yBxz4C1/RqGDhYf8EGTSmlgN4Bme7Gkdn5iW2DnpO11jSQhRB8EowyTWKTBP5vSukRM+K/8UIikcDlEJuYpKwv2sOLPe68FdVqYm6wY/oYWjoir4zXz5O47jSWPM4+0w4Ws88Npiac010GLU9gtIvxkbZCU6V5KhIWpHqTrgYYdgiReGj3AkrT0VosPaE/sLq8H7J43MciAVSmQB1F7Lnf1CAtXHPyiMms73YDaUBmNRckeCKfH5KCbNMEp3NfXknebjuJQ/KYfFTNYipGdhmEbYzbJjMX1G4+EpJ1wCh5hfcZUQRHQCw2A9x6+mks6JNKbyVhWdqcAUNY3RDElNOsmEiiA7Dlpe8y12+/SYtorlqcMLVe+4vAjooqFkiR7jtvDleJqutAIqaqfv+C+hAwUPkM8/wDCE9i0sg0orGIc/fKzrHEaPLQ5X28LgJMVsGagifi0EB47UYAHP9dK1/yqfpWj/+kKwiBMsUQk1016ySC9taWDlfwW7SCD4jQuFIwR9ikv59iiKXy8S0QNdj5vwGz0hEoo34Yw/meE0PA9V5NxC6kS9ya9+ixQn5G+DnJCB1psDo/OhdjgjlY3TJ5huwGikhuOvZyIZfbwHwpRtyBbj3M1eRvWmO7z8XBCfH3ypqh0w790Tu6KuFNfqKg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1cef17-f554-4556-0a54-08d84a557cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 06:50:29.6909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Cm8Tx7TR8DdtQRzL7D6/laO08sUwhkSqLCy1MKhC8Cwry+abxxxdkFq/yk5SWrkaaWqCkQGyXgKKBHm19r6Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3033
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
Cc: "Gu, JiaWei \(Will\)" <JiaWei.Gu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping...

-----Original Message-----
From: Jiawei <Jiawei.Gu@amd.com> 
Sent: Thursday, August 27, 2020 10:32 AM
To: amd-gfx@lists.freedesktop.org
Cc: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Subject: [PATCH] drm/amdgpu: simplify hw status clear/set logic

Optimize code to iterate less loops in
amdgpu_device_ip_reinit_early_sriov()

Signed-off-by: Jiawei <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8f37f9f99105..696a61cc3ac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2598,17 +2598,16 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_IH,
 	};
 
-	for (i = 0; i < adev->num_ip_blocks; i++)
-		adev->ip_blocks[i].status.hw = false;
-
-	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
+	for (i = 0; i < adev->num_ip_blocks; i++) {
 		int j;
 		struct amdgpu_ip_block *block;
 
-		for (j = 0; j < adev->num_ip_blocks; j++) {
-			block = &adev->ip_blocks[j];
+		block = &adev->ip_blocks[i];
+		block->status.hw = false;
 
-			if (block->version->type != ip_order[i] ||
+		for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
+
+			if (block->version->type != ip_order[j] ||
 				!block->status.valid)
 				continue;
 
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
