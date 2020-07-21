Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73100C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 07:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A19B208E4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 07:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VHfvex/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A19B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C046E466;
	Tue, 21 Jul 2020 07:05:52 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700059.outbound.protection.outlook.com [40.107.70.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B786B6E466
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 07:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCNNLZZD6JHtGzm41wl0gY20pJPaqhG24T4mbT9bps0A3NXuqUPWxSWeXC8px+Zhay2v+2afkkTI24f9tRS4D3Ki/bkJU/075czJdHuhyLFm6GEb7NmwsXcTo8TctAOJ3iBFPOuKRYUY6VekBwBnR2aKFajOt7Xydp9ecsQzPGMJa9fFLMtXyDSJ3hDKATRLbJQRFlpMgE8dVWfO3fFPgIFtTvnahQXkMqjRdqYb6jjz6+7ZP3Yax+Bfa7lcuSElHI7c8+feKxbWM6HH6gufP37Rrkul7oU9jnKbY0AKakC6dzacU1HY++3Sl4HITm/o9DYxJdz3sv6m87uThjbHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTQubq8r+Wm1yTNX7q4LgiFTAshm3ykPSfds0Y7NNd4=;
 b=WHNpB3Ljs9lWKe56Gctc+Igh74AUdH8pxMlny8xUP/fXxdpAJOHsg5rDSRFYzPAPNw22/vr060ntS9H4VEFxk5GbqPd0YTsAE5pQdiU+RKCQ+VTx1dTiDAdLI17DnPhDn/zXZiAfhEOn2Vrd+qePO9f3AJjk/1ym4Pj1qFrrq41E5t7nY4OOQW7ODfDtCd69NQt5NLsmpIvYlWCuYtikEhzABNJ8+b3s71Or+qLNUMEx3ErBHMRFvwBAWXmMkeIBifyNowpupCb5gzfHFfyaC8MnrcE5V1vr28zXxX5PVQYfkTrTXhEWQlqFwKjk4fLkJ7H4lXugxlf0Zz1JP5mEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTQubq8r+Wm1yTNX7q4LgiFTAshm3ykPSfds0Y7NNd4=;
 b=VHfvex/nQt7NHLaAuBddxn7ysghiTiC9lj+ipe5wMDk0/TTx/3VmrgRbIiOGYl4Yh6oOr+hQQJ5PvPaGyqUWvHlDI0tm14bIsjJPD2T/whdRvqfd+PKLHWVUZIeEs87XwMKV2FE2cXfelZecczLJxOp0lDIGGZ26f2iBVppebvQ=
Received: from CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Tue, 21 Jul
 2020 07:05:49 +0000
Received: from CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f8a1:6256:9d5c:8a6a]) by CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f8a1:6256:9d5c:8a6a%3]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 07:05:49 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: skip invalid msg when smu set mp1 state
Thread-Topic: [PATCH] drm/amd/powerplay: skip invalid msg when smu set mp1
 state
Thread-Index: AQHWXyhnlGZOc5AoM0uvQJO3eRWHDakRmw5Q
Date: Tue, 21 Jul 2020 07:05:49 +0000
Message-ID: <CH2PR12MB4326CEFA5554F7C91B6AC1ADEA780@CH2PR12MB4326.namprd12.prod.outlook.com>
References: <20200721062952.1255025-1-likun.gao@amd.com>
In-Reply-To: <20200721062952.1255025-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b244866e-a486-4dd1-a10f-3549956d37ac;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-21T07:00:58Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d97a63ee-96f9-4d99-b25f-08d82d447fd2
x-ms-traffictypediagnostic: CH2PR12MB4310:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4310DCEFD6BA75777935A5D7EA780@CH2PR12MB4310.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oy10+O31bmbQzaknEJPKWOInFqo579fhrpn8Ub2dZsM0tu7xi3nf/ZTAcjC6tHcKC5c2ETi6UIZQRsHcP5FIfhsWdWVrTyTtpNPS24augAGrka4daKABpcLF8276z95T9ZIX5ws9398CffENfDw56//Srq59Kc/ls5ZntBYhUHdJ3zqys+qXakVAbKlRe3BugXkc+FOLOLVr7xfl/cxOCegaJvX1ORebNV/7I0PTD/boMT8ntVsIGySVSD8883Y1mwcOvKqgQjGj7TE8XwTl/MmajT8QGWUe2lG08c174KOBgMa7/BwRXdt4Z+UWeFlRWBiRf5cWkCUnUL97KC3wVpRS1o15dofkLV0ZA4Dw5CM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(71200400001)(316002)(53546011)(7696005)(8936002)(6506007)(186003)(45080400002)(52536014)(2906002)(86362001)(26005)(54906003)(110136005)(478600001)(8676002)(83380400001)(76116006)(64756008)(966005)(66946007)(66556008)(66446008)(55016002)(66476007)(9686003)(5660300002)(33656002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ElfK2TX3mcibkMhPK0vWCFu/7iYLuIt2uiGvguwzNaV4pcyaJLP9axu49aLCzX0dIe1RuOtDNxzjrhp89igdeMGOmo4946qPGNXggzPXGj5jKjKXVC9+e/RmU4TjzSE3oXS7oCTa4wYrNAD/INrmvEpCqwUHMqqkAfHARKyPphKSn+ijNuroxRw7aMjiu+rPIfd5Wbcd8cibSj7Cz+x051jx3SDHtVcbCia/G5OQr08Ainxsg4NF0iOT4C/K9sz2NQdS1FfM3mnsTLhYlboPcY2DsJtCOBieiROMpll0IKuG83y7le0uwIyV2kUbGxnCl/nO1CLGlu9K/Fb+ZNUbCbJ7q9JEhPfVzt4Y7vt5Zy3et81gSmsQ7bF3salFStuZpDUtdBAR9TPZHZGsnizdbjsIwfrX5mT1u5UEKcmNRrF+aFmgqBQXaRFggqgfEjMpIwDkPFpL8vvD9dPNDrRCw7VpL3fc7RXuW7sAOM7nCZnz1QH/0XmFE5r7dO9bN2us
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97a63ee-96f9-4d99-b25f-08d82d447fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 07:05:49.7131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGkJHO19RLeTUky4SA00r/3zTjnoIu5MegJWJhy0eTpirbr5qSV5cswtAfkXInYwVIUdSYlMuTo3L464QZyJDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Sheng,
 Wenhui" <Wenhui.Sheng@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Then why we don't handle it directly in smu_cmn_send_smc_msg_with_param where is more near to the source of the problem.
And there is similar logic already.
if (index < 0)
return index == -EACCES ? 0 : index;

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Likun Gao
Sent: Tuesday, July 21, 2020 2:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/powerplay: skip invalid msg when smu set mp1 state

From: Likun Gao <Likun.Gao@amd.com>

Some asic may not support for some message of set mp1 state.
If the return value of smu_send_smc_msg is -EINVAL, that means it failed to send msg to smc as it can not map an valid message for the ASIC. And with that case, smu_set_mp1_state should be skipped as those ASIC was in fact do not support for that.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I31b40b87532a1d7549b26155d4ec8145b5e3f101
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index b197dcaed064..237d8ab8b40d 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1590,6 +1590,9 @@ int smu_set_mp1_state(struct smu_context *smu,
 }

 ret = smu_send_smc_msg(smu, msg, NULL);
+/* some asics may not support those messages */
+if (ret == -EINVAL)
+ret = 0;
 if (ret)
 dev_err(smu->adev->dev, "[PrepareMp1] Failed!\n");

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CJiansong.Chen%40amd.com%7C307b4326530d4a8afb5c08d82d3f877c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637309098198014944&amp;sdata=mnZFtst8g4yxqOjYeoAmFuQvVn8Y7j4tpf%2FPLvaTCt8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
