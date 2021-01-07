Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990FEC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 02:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B09822E03
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 02:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B09822E03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B16EB88C07;
	Thu,  7 Jan 2021 02:57:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E377388C07
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 02:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RN4siejoUqMxlHR1CnEf3te0SyjF0rU9wp4EN2E5n+F1Xj3MDEbZgNcWTABIUvwGE7U5oPhNBScUVpRNpLAVEauB+B1J3MvI6pkI3xdpdbvjp7jKWL9eBuGVrZoIs/fetZFcXEhzWFc+kkR0db9psTAlpD2mkIUh6l6VZH4RYvIrh2voGZLuxImhfiA3HAJxgvgLHim5/tFNxBqBUBKM5a9/RM7hkGROAyS2uXUOD1f6WU8oFuRAlmKfAKjhpnGasTR+oxyR/83aKoDSgL/4h5lhs3COjZ/8MUWdyWX7RInoCeOc7DnrOuChx6xlcrh9+ugWqc2UtQuIOxcyRzG8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5hySd4ncpLrxM6/wKCCpOZjrbafLlH2XS0CqYVo+nQ=;
 b=gAv0tUiCNrUL5g3DoES/3x2fHI24lC6WfgRsx+1Igsh4O5EJRu8KNpM3y4LZjCQiSzEVYDsEIrXIzFDluJvnsTsQohnIl5HhCvA/TQYKl6n+ULwkoVaPUgVznb5p1vBZwnV+kXURxCGVZhTnfWy9tqDRfkxSs5sBQAbW9F0lrJElG8dm8NluhTz0hRGkRqv2OTKvkBO6loNJTnL4dHRCUh2UN8D9wwbeRNWSqHh4TpWqee0kq7TvJiqBCGh/ssyrUpG6m4yi/rHQCuD8p2CKKELkeDULzJ4T0J3QRuNnFo2wYuEjYQJiNu/YuKVIfPuq4fry8vde7i2H/w7tc9dDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5hySd4ncpLrxM6/wKCCpOZjrbafLlH2XS0CqYVo+nQ=;
 b=Grwu7iUkxbVsnfEAs6Wm/4GB8Bz8CBZBpk7l5IyW0Nlomgh+mtO3J0MK4LP4uZP6MUJ+eKzSXz/PptrMLet2rHPRNiaoKWXrwrM93HnS+9xnYDjbNivRWYT9iRDo2rv3/CSXonkSPqyqK8CbIFQ4ThQuhIRoPElF6+WVwU9GIXI=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BYAPR12MB2854.namprd12.prod.outlook.com (2603:10b6:a03:135::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Thu, 7 Jan
 2021 02:57:49 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::ed48:1313:acd4:8d49]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::ed48:1313:acd4:8d49%7]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 02:57:48 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
Thread-Topic: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
Thread-Index: AQHW48gJuicEJ/d+BU2PvSe5PdQytqobebkA
Date: Thu, 7 Jan 2021 02:57:48 +0000
Message-ID: <BYAPR12MB3640EF7FDA5B5672BEFA87E48EAF0@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20210106010515.486545-1-Emily.Deng@amd.com>
 <20210106010515.486545-2-Emily.Deng@amd.com>
In-Reply-To: <20210106010515.486545-2-Emily.Deng@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-07T02:57:42Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6fc5ec22-55f5-4d9d-a585-00009f16ab30;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2021-01-07T02:57:42Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d5d0af9a-903f-42dc-973f-0000278a5948
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c9963a3-b68f-436b-794a-08d8b2b8044e
x-ms-traffictypediagnostic: BYAPR12MB2854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2854DEE7493482F16EACC4FC8EAF0@BYAPR12MB2854.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GF9vSxCTm0YuoZ4CL3Zda9sxiZx6n1/UV+dtaGr8Y5oXvTsAXVgABFeAywk+LpXhq0r25JPDRZVxaFV0y3KuFl7htGwR1joKIRRG5rUqVAYV9DRSI4acaJ8yeGj2V97d/escYU5mipA/ezvMLdYPkwXebVaC/MjbsrsCb2VLUJfkxjKLg7kAYVKBXKWVloIdy6Bib0JjcWOoIUO0qshLS34EklW1wrT0vGMjeEzjgFSKYO8CB57rhkJkx0RcohoILgCpvxvOOCGmo7xQEPgGUbvwrN4gvMfi5Ij626D9alNNmhZ9+ErvZ32hTw0D5bUQp3pcmBTJ6lSUi9DSeA7RrIBJMH44VYEPBPvjXoNzZefaG3QSJkoyxm+0R1F0AwPZawDuRZXJM0o+vzE31EXIxrWGy737OYCieNj78xHM/vo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(110136005)(83380400001)(52536014)(33656002)(316002)(478600001)(86362001)(7696005)(6506007)(71200400001)(66476007)(76116006)(64756008)(66446008)(8676002)(5660300002)(2906002)(66946007)(8936002)(66556008)(186003)(45080400002)(53546011)(55016002)(4326008)(26005)(966005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3Z6+RUqIVK2wtPqk+XUvthbVRhw/AtdSCMCI4AfSZZBP7lb4/x2cCxi8kqIv?=
 =?us-ascii?Q?NaM23WEsiHQyND80qxHlk55whfm2dWkHSDX60Wj5dEFlDcahIQSrnRsvCrWa?=
 =?us-ascii?Q?P+I/0UyOUD3/Dru2yJX+rDPuZ9pYv+fxMs72aD6GkLdiML6EyLAf7i857KtN?=
 =?us-ascii?Q?c/1sGh5aBvCLxJLgMwMFuMhNiI7KuiqadgWRuq8F213/VsbJM5Vkj0RWTRH4?=
 =?us-ascii?Q?Ku8piI6EYXCm/AMRfVh6Fr1d/J/ubVp9fGLjkZ4UbmvatpoSDCHtEKEhLJWA?=
 =?us-ascii?Q?1oaOJBj6lT9XCh29ngN7bQqtt8JkOf6+fo0jZM+12RhVeSsHh+JvTrRogc9u?=
 =?us-ascii?Q?zVrrZqpacfDVG/6YoZfFNuc6+HfXZKKIsFk1yG0UvdfQZb6qmbLShW/+iyo0?=
 =?us-ascii?Q?RjTc3zHhgyfNxIlXVRcXVzq+fRTXB41K1n8X+i7rqR+oMHI9Ly586Sna4yJJ?=
 =?us-ascii?Q?bCe+zpTkZTGScM8J9T/rPKLJrWCZN5gNx8iEdlrnD0WBy1Ze5uXm3YGItykM?=
 =?us-ascii?Q?XIbfUv5f9+Bz8MW3nHqg7j/YZ698AiPtax1ESflI3Wl+6pmb2h+hi5PyCmrk?=
 =?us-ascii?Q?u/V0wgd6CqBClBmffEfG9f3ZwzvZHKvAliT6VGQQ2ctKn8M45S5lkF4b2Nv9?=
 =?us-ascii?Q?dxCimi2tLjyULOHFLTW/6IdMjsnYLeWJlEXOoltrueAQLzT6DVDROSrqKbjC?=
 =?us-ascii?Q?awS2D7wF4yw41PBetrSoDqWf2aei5gyA/BFpU6/ZRtiVXvAbkszsHMZLNhja?=
 =?us-ascii?Q?haRCgWnGcXIdGOsvPCoi9CKjUx1kk13+z6yGFZ8MBxMrMRwIdYCVXmAAO7Kw?=
 =?us-ascii?Q?MY1poVA9cEuObd+tbNuaSSi2rF+fnakfnnOHqJYaNmoM5bZ5F9iMGyKShICI?=
 =?us-ascii?Q?RXmIoZdDUoOUmyIdpJQPGLqnyV/5LFweapBK6r8fMse/414enQuZvv/DgHdW?=
 =?us-ascii?Q?iQ8h7j/9ZPAJHK92BP/odgFxDoUW+k+J/D6yEtsIZYA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9963a3-b68f-436b-794a-08d8b2b8044e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 02:57:48.7334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OiSxuuvWlPUNwCLvrm5RaK2qTqPBG987zwdYajZOUJqNJRUPEcCfNnfDWXKwvFn1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2854
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hello Emily,
The average clock value is a little different from the 'current clock' value.
May I know what's the purpose of this patch to display the average clock? Any issue or any customer requirement?
Thanks.


Best Regards
Kenneth

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily.Deng
Sent: Wednesday, January 6, 2021 9:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10

[CAUTION: External Email]

According to hw, after navi10,it runs in dfll mode, and should read sclk from AverageGfxclkFrequency.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 51e83123f72a..7ebf9588983f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1673,7 +1673,7 @@ static int navi10_read_sensor(struct smu_context *smu,
                *size = 4;
                break;
        case AMDGPU_PP_SENSOR_GFX_SCLK:
-               ret = navi10_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+               ret = navi10_get_smu_metrics_data(smu, 
+ METRICS_AVERAGE_GFXCLK, (uint32_t *)data);
                *(uint32_t *)data *= 100;
                *size = 4;
                break;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKenneth.Feng%40amd.com%7Cf8dd063d81db4666206308d8b1df2912%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637454919344238874%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=mXK3%2F5g4lqMFFN1ovavfXdbuypZK2FUGbAEce9VPTWs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
