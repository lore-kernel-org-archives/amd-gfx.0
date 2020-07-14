Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A42C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF39F207BB
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bKp8xWOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF39F207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 752D46E892;
	Tue, 14 Jul 2020 02:34:40 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760052.outbound.protection.outlook.com [40.107.76.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E7C6E892
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 02:34:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqZahY7Rst87+AB+jpomP5XaEzVk0+VoRk8PZLJoqS+PyDckIFWqrf2vWfdeihRlaUEZaptVFlA7ckag9PVQfk8BX/BeN4uYB8VXcFwAoWiwnR2uLqqcMD6pn5MFbs+kbWbPT9sG+EwF9XxjqYh8XWjB5wudS6DxAnkElgtewqU+5E30GXa0dFZ+gtMgFsEpcKWlv3smLftdJy7DGoiOFv2pvgi+2wYUbPEKGGolxk9rPDax6EME0UUKFZd70zgcbG9t+jVVLL3dURkfc6EmrDsVOvQjE1sxZy11dJjDfCsHaDIF7CuH0nKSqnT6lf6ixim/czh3uUzkBn+R/DFrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cQk0YunxTTjNEA0UI9lgw1EFsXjPUdT2tVgC+26y8A=;
 b=GZoV5G8z1cKEqxBGe4hJkH8CMtvqedq2uI6He9NxQ7LAoo5gudb1zVSOb4lHrqg6f/E77ur/FMJGe4uuEmOF5WFVJh4yOROrXnNzAEllWa4YuhhSi5dWlxlaYScWjzV3YKAHUp6umAmXJkSQUYVpFHsA0bu/DYMqr6Cgv1HdOQZHpk8tzPRuA+GjOlTPZX3IXp4/QvL5WrzOde8xz7KHqD0pCvNMtZCdNdNgl+XosVRjG4zaPuaoDFbvmchXEDCSeHMXs1lg2bIp39DIM5obkdrYwDkHZge3F2mqh+kuuij+jxp8/jmSI/WZWs4ys9r9XwO4QQJFyDkFDCzQqzEyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cQk0YunxTTjNEA0UI9lgw1EFsXjPUdT2tVgC+26y8A=;
 b=bKp8xWOdfu8e8wlmPnNCGGpqA7pFjiUowiTGVCSZe719kxLY/xaHosiaIqCqeMNtzXNXP6FMoIXjpvLPPWUjYaQdW2rXWeUKRCQjgWTYhQB7BnvBE4IEsS5kgtYIebp4OAtCCb1vcQcV6WWgjpr3772ef2vJOrm4IYbDRD2dJqs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3866.namprd12.prod.outlook.com (2603:10b6:5:1c6::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 02:34:33 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 02:34:33 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay: Modify SMC message name for setting
 power profile mode
Thread-Topic: [PATCH] drm/amdgpu/powerplay: Modify SMC message name for
 setting power profile mode
Thread-Index: AQHWWPCMh0Kpf5SGkEmPHFdQbJHYAakGXDRA
Date: Tue, 14 Jul 2020 02:34:33 +0000
Message-ID: <DM6PR12MB261939FED185626BECACA785E4610@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1594629261-18409-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1594629261-18409-1-git-send-email-curry.gong@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bf15c31a-ccc5-4c6c-b6d9-0000e20302f5;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-14T02:32:40Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8adf2d96-32eb-46fe-afe6-08d8279e7176
x-ms-traffictypediagnostic: DM6PR12MB3866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB38660AFEC93EB7735B7FD293E4610@DM6PR12MB3866.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mMuPhivsI0aIHhFvh92RZuxXRT3DrICP1TpWK8X9ZTSOPMln2UKwZOX02Wef7QcywZCdMw0gtTBBUA2qJnCEwjdUtRozV1bp8LWWEtUyOQQpvvbgZXisfgYO8JNH0hsrBUNabQb7RaM0/qK7QVDsHWNpHvil399Q9r5qf5MfafuZQPSj5a6A0Zwcig1ovTK6uCzhNr3WrhL+zVO84sC4u3zfcJ+L+tykXmYyKDB2Edg3LhdvKu5S8LIv6bu0Dbb9Lrr6Lw3rSKOsFvcO/mkdntYAP0GFj+wiQ8l9Zbu/0vWaAuzc+ewtIb1PDLYbKj9uA4zl6GOnyIaZtlAxDXPA3Deax/8/WsPm3oNuf9UeSAQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(45080400002)(8936002)(52536014)(33656002)(86362001)(966005)(7696005)(8676002)(83380400001)(4326008)(478600001)(5660300002)(26005)(55016002)(6506007)(64756008)(15650500001)(66946007)(316002)(66556008)(110136005)(66476007)(2906002)(66446008)(186003)(53546011)(76116006)(71200400001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JYFJItcat6SXgR1yQP6hMTzLHFDGgmV53Eg6rVNtUbBIxwK77kg0wqbpkJcpPNaXj1I26snZH8ecWqz5a6fTu3QEdPxLmeBUaSW4vlDrk89SFtVLdw7F2NP1efGJxMZhw0Lu5CxHwgPdRMsMWBUdPAbV090dUgq+ceoh/GatqtSuAdmR6w76wwNIdZAnW7NbcGPm2cuIPCs1oTdbcZXWEZfNPk2mxjUZX2rl4CWhOsLkJKJHMaDPR0sUHp6FAf4p5DsQxvzcguBueLNE6YBnqDcymxikXlfdunFUSEFasy5Ghqcr3A7G7lWwqw9RFd6X72NWEy/mOUgzcAQ41mZQj/fKNKDWcNt2DDZ1R28Q3qVHtwOXoOapCApHoQAx8h06X9q7I+mUTC68p8HHljOEHxRu2BOFVFN2mwLBY+0c8c8yJ4laV0KACYocfjjyRgjYdWv5RDPfgHLQYqCG4zZoeLc7ipMYcY2e8g71dMjuHumz9FnRjF8VDLh8URpWl6eZ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adf2d96-32eb-46fe-afe6-08d8279e7176
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 02:34:33.3195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WoLJOFbklj7mSJz+GhuTa0iZwCEjfUQW7C3CmD3srYqE8ajQP4pmBbe6+4xzBPy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3866
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
Cc: "Gong, Curry" <Curry.Gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

That's true.
Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of chen gong
Sent: Monday, July 13, 2020 4:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gong, Curry <Curry.Gong@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay: Modify SMC message name for setting power profile mode

I consulted Cai Land(Chuntian.Cai@amd.com), he told me corresponding smc message name to fSMC_MSG_SetWorkloadMask() is "PPSMC_MSG_ActiveProcessNotify" in firmware code of Renoir.

Strange though it may seem, but it's a fact.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 5071cfb..4fcb51e 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -698,7 +698,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 return -EINVAL;
 }

-ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+ret = smu_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
     1 << workload_type,
     NULL);
 if (ret) {
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C28cab167186b4d45b98608d82707913d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637302261221689997&amp;sdata=16o7HVJd1iLxb%2Be%2BUkxHgp2%2BtEh%2FDLByI5iA7MAeaQc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
