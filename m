Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA297C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5065D6113D
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5065D6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37076EDAD;
	Thu, 29 Apr 2021 08:31:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4DA6EDAD
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVJtPwrNLrzkM7hLOb4wYJ+FkYKuqfqdibeaXvZeJpSAM3FFzcW8qgP9FZvWYj0HVurjuFcuvAeU8oPnZn6LcwF5GKrNbZ1UV9D3UrT8XlAJXSyXcJnOhSNvI9whc1JraaehQow4o7AdK9c1lPZ+sIqjzR2o8OXp4XUyp09Ei4/Ss0oJA1qMVrQRQrqyyyGsbx+X5F2Vc7fGusnYcEg34ZxtIuBpLgKGJI9wLwHg4qb+2U/Rq2KOe8TbvrmICpwOTfbeM9Hhd9pOQD0MGbH7URqFVRIPP7cnEKQGNhBLK7vSsCkRro62ElYJ9+Fzrkq+3sWGk9zOCeb0g+PVNNwmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0484pPldvyjonmILQCWn8B+ZiMTS0QsMcfgtIVrw0g=;
 b=cRfwuaeFBjUvVzRr3HKHw1PtxnpyB3nxVDrTMEpvGTxxx9RWwpUNB6ea54wJqJ0wRbpKlRFTJItSTSUupRHa+DqobsXKsMpi36qfZlhi6KimFWIQ6vkCaVmBbFRcIM6U87do312Acvr6J59h+RLBncre3JiKprT1jA9bdSaTnzUqAOPna+3sOQr4aGcf/ghTVDTRpjiMR5EPI4eXCElQFmhw1E2kIbo2mNWma5a6x1StPdkkI2gjY8wZHU6vdQNLNken+D43dH4fpZ4u4qTaMzPHvEGZCKMeO/RBj4nMOQMS25RtZG6euQaAkzGEJAB/s1rbtDveJRCVwkAAqzzzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0484pPldvyjonmILQCWn8B+ZiMTS0QsMcfgtIVrw0g=;
 b=YpwXwttXSltnHDtC6yzx0kGMOsnsUKwtengD/kjKvWAI44bLGksy7U/kGc17tnsL0bKQNxvJys5XjjjQdHmBVPZAwK1Xm18WZaPxI/1VLlwBu5x5+rhArIpukmWvCoT/SMkZ4CXtCRAGzyXQIgB/EkyIZG221XDtB/MfsjA52Oc=
Received: from BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 08:31:42 +0000
Received: from BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::2da6:ea50:5bed:f029]) by BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::2da6:ea50:5bed:f029%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 08:31:42 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/7] drm/amdgpu: retired reset_ras_error_count from hdp
 callbacks
Thread-Topic: [PATCH 7/7] drm/amdgpu: retired reset_ras_error_count from hdp
 callbacks
Thread-Index: AQHXPMCNKuZMgPN/HUKq4XSSHhfCyarLKqBA
Date: Thu, 29 Apr 2021 08:31:42 +0000
Message-ID: <BL1PR12MB5350099A6C0F95490DC7D815ED5F9@BL1PR12MB5350.namprd12.prod.outlook.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
 <1619677546-2630-7-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1619677546-2630-7-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T08:31:38Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=da982fcb-fe86-4194-9034-42fe452b7a08;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f23d446-7b3b-4875-1cbc-08d90ae93781
x-ms-traffictypediagnostic: BL1PR12MB5223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB52235651B002EC5A07DF7379ED5F9@BL1PR12MB5223.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +4RIdfiWWz9TjPcF201yLg2pXrKlTIHa6xXXIXifV3e6RbtIa7X6gi1hJUJvT2QtU7+jkb4uy3Tky+397vHX0e9M5Um9tS6Qgf0Udd/Zs2qRFK8dhVghba90+kfYA9chhbt+63LQNhDAb6/33wirqDzRY3NXjTgwoctv6uwv/EPFb7a2eeF2Kx9XEajbrH3BUl7Y/D0cfa90k4jDVrBVtT/Khq80YTgOhBNN9bKe43MNoB9lfhnj+Ry923jzmQ3Ho5Cz5YgO61DrcxhQh1CJmHNwwuoNF6RzkQdnUyQGf56+S8uFU3P8LXQ+Ii9mX/16AKdj7TbHN/5FxNPUyifIZC5P62dfGpWIIoCT1P6GG+Z1T98+w2gbkYOzD68pwxXYHS/tErVZIBMZ4RkSSk5Ek/PqS8yFsWA0IEy8WnDT0cKuwNz8NUKuAVLH/xl0YMYM6DovOa6MnzCcdwhKsWptEtkGRRu4Vpq4f6biVA+SCgZL0LcPrFrzhdeyaqBZJEBt5bXY0pCFKF0715+QKGt98lEcJaeopTnq7Y3aXoaj/K/t6S86Imhs9JLbYyx1ZHz/IMxLvW2GRWaieSM/nFSMMv8h3GA4HFwe8npsfDCqfU0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5350.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(83380400001)(4326008)(71200400001)(8936002)(2906002)(52536014)(122000001)(186003)(86362001)(66946007)(66476007)(9686003)(53546011)(33656002)(478600001)(26005)(38100700002)(66556008)(7696005)(8676002)(6506007)(76116006)(66446008)(110136005)(64756008)(55016002)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?SE85MHZkQnYybW00NFV2d1JFeitDNGo0bE5BZFVLL3ZRcjJDWjQwYXVaOHZY?=
 =?utf-8?B?OXVHcURGNzRmN0dxSmxpQ0R3MjA5KzZsMVBkWE02MjJ3S0ZTaktIUDhWUEY2?=
 =?utf-8?B?QW9qT0IxRVhkVEE3MnNaMWd2OTNXVHN6ZjVmRllUa2FqSlF3UGlkR3laaHFv?=
 =?utf-8?B?TExTdkFJQ2lFbkpPN1ZESmE1NkxsNGpYMStOUmhzN3hDV1VIb1g4MjN3TStP?=
 =?utf-8?B?WUtBamRFQlhNVzhuRkVYekJBQVdlM29LZElPczI3NkxwRWxFOVNvUmptdXFF?=
 =?utf-8?B?Z0hSRkR3UlFza3JKOHcvZWNmM28xUTZVSG5YZkV3TXRRWk5hUXhidGc2YVR5?=
 =?utf-8?B?NUdKd3phQkVQT1JIdmRBSFJMd0QxV3cyemx4OWUyajFodGx4UWNnbkxXek4r?=
 =?utf-8?B?WVVPckdWTEc4STZVRUZrM29mclRRZDBWU0c5MTIrNVRDbDhiM1dOY2MzTTBI?=
 =?utf-8?B?cXZkU0taT0hIYUtVL0RkU0I2dFNnRlVYNGhJR1BFd2RhQktkbDkxbW5KeDF3?=
 =?utf-8?B?YUJoUnVCRVBGeUxmRFFpNEx0YzNTdXFRUDBYU3NXS212OEh0MkJvTXdKZTZJ?=
 =?utf-8?B?aThYMEEzUkkwbUdMbXYwdW0vNWNiWmtXQWVwazF5dDlrdGNVQWt5MG1KbmdP?=
 =?utf-8?B?K09WRnNBMVN1SkIrdUxXMXJXeE9BblUrd0dBU2tBYi9HRmJzVE9zUGd2K0pK?=
 =?utf-8?B?RjRkanlabTZNRkZldlZ3Vmwya1VkczE4YW5QdlhmNXJSWWp3TDB6OTVBTzd3?=
 =?utf-8?B?N2l4QlhrQ2dhVTB4T0dnNlJVTjduZVFMZzJycU5oWjRYZmR0dk4xTisrV0dh?=
 =?utf-8?B?aktMbFEweG9wM1FnNjNHK3pZMk4ycHRPZGI4d1UwaXJHK2UrOXU2RWlhN2FC?=
 =?utf-8?B?SlFFOTN5NDI3ZzEwRlRhci81WlQrb0JDSmJCeVJwR3FaaURQUUhULzRENW5C?=
 =?utf-8?B?ZCthTGZBTEdDL0FtQlhhWG44cEdQTkRtbFJSSFdlbEZxbGQzK2RFdnBwMSt1?=
 =?utf-8?B?N2RLRmQ5ZVN0SDZvTXZpTE0vcXpyVmNrRFNST3VUUW1scWZETFMxNzcvTkhU?=
 =?utf-8?B?VGlyS0sxbGY3dWZIVkV5NWVHc3p0dXRlM2NobmFQTWtoMUFyQzlOb3U3MVdG?=
 =?utf-8?B?ckkxWS9pZUkzNXgxU1NWdnhhZE5TMTc0cTN6QWxKQzh2VGZrVUxFNjJIeGZ6?=
 =?utf-8?B?YVM5YVJLMXBKbFFJN2hoNDVNeUFyWDFSQTZBSmJndXlzdmd0RW8rR0NhWEtE?=
 =?utf-8?B?emRFcDFiWGw0Wi9aa2dsZ3ArMVJRVU4xUkMyYzl1aXpLa2REdWIzUTBJYlB1?=
 =?utf-8?B?UWdZNEJUWG1MSDRhUHpDVXdNOHFWVjdEK2EvN2JTeW9kZGpvSFFuNmVVK3FL?=
 =?utf-8?B?TFFZQWJIZTVWN0V1M09qWUcwQmprRkk4bElNZWY5OWd1bmNoQTJsQWF0dHVQ?=
 =?utf-8?B?M3VQSi80ZEYvTDNKTG92UUVBS0twNUVYdXY3QkZuUERMVGhuTEl4YVF5aVYz?=
 =?utf-8?B?YUloWFlYOWExeUNXTGpDNUVjaGFYdlFEcVNBdUFYTkg5TGdheUhzV1U3V2th?=
 =?utf-8?B?WjVtaHphcnNCV1JnK21weVJUUk9LSTNBMXpiSGYrYVR0WnFqMWFyeWhyb3lW?=
 =?utf-8?B?dUtFT0FwNG81cS9jdE1lcDZwRSt1bnpUQlJtdGlUYmN4TjI2RUViTGVXeXJr?=
 =?utf-8?B?MUYweVpyUTVvOWFraE9pdEp6Slk1VjlreEE5WkIzallKK01TR2FvQ1pqTzVs?=
 =?utf-8?Q?W1gFeJ15+/NLd38F/CbTVSg42xDQg/TTSdTKnef?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5350.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f23d446-7b3b-4875-1cbc-08d90ae93781
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 08:31:42.2958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWUr4bByk+GOumpf9yqmKNR4izoHfMVW5dUIPKGNXdOed+hbWlA4LIquOXo1OfCh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

This patch looks good to me.

Reviewed-by: Dennis Li <Dennis.Li@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Thursday, April 29, 2021 2:26 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: retired reset_ras_error_count from hdp callbacks

It was moved to hdp ras callbacks

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index ba6f272..7ec99d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -35,7 +35,6 @@ struct amdgpu_hdp_funcs {
 	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 	void (*invalidate_hdp)(struct amdgpu_device *adev,
 			       struct amdgpu_ring *ring);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
 	void (*update_clock_gating)(struct amdgpu_device *adev, bool enable);
 	void (*get_clock_gating_state)(struct amdgpu_device *adev, u32 *flags);
 	void (*init_registers)(struct amdgpu_device *adev); diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 330c0f0..74b90cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -159,7 +159,6 @@ const struct amdgpu_hdp_ras_funcs hdp_v4_0_ras_funcs = {  const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
 	.flush_hdp = hdp_v4_0_flush_hdp,
 	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
-	.reset_ras_error_count = hdp_v4_0_reset_ras_error_count,
 	.update_clock_gating = hdp_v4_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v4_0_get_clockgating_state,
 	.init_registers = hdp_v4_0_init_registers,
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
