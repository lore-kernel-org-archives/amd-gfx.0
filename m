Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A91EC33CB1
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 08:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6234B2072B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 08:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D0NnZRsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6234B2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31916F3FC;
	Fri, 17 Jan 2020 08:12:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB556F3FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 08:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHHRYPX5IIUDj97fmIk4sgD1IY3O+dKLVIWDAagmNpwBvWTQq3crMN7ZttwvNKRz6NLuPuyc+WNua8pPmu0nF7qfUHNEtcXzlfx94MgT38AmRCDNdq9kqAjb/8m4EjcF0oMhcdsU4FkDQsV3b0arSGBrJla0YcfYcV6p/+5nldutBw7K9IvyJwJcT3CVW06heiCv4fAyyYw6sYeP4STxzbPBPIfND7Ey2rLaY/CaeVtzgFTWn/xii14zBSmT9/bzJtjL/TWuTz4NhqsE1zaHbLDnHcmAtXIRadK2W1Prw8oTwUvpV/6VzuFu/yeiss8kOBS7I41nG/5a9riN//8lXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q//FzTwCzlgZtXhtnEDO8BvOYB72trFJURqERdK5clU=;
 b=GK12nJod79atS0D8pHrYCjg68qk/+DPX4BXFx9kIlhLmIyACr9C68C3qNXe0rmhMRngeNrFb7u3DhZhotJtD3TRGjebj9l+hwbhWWuAD3Tu5Z4txJEZeyxa3TtYnx53qHfBdS2d+zR2NDpCdutIrex6owJXkuuhE6Z4QbFtsUnsMLtF2VrSUDeqpbqGn2aQo3px5zgWWm/kplqQLj0CTg7d6qKsB0veQZhwhhTdDAqbes3XNJnZbLAMspe+JhbNCoRubYRyxBPVEK1up/nHdDzkLD4OwhkAgFXz9FsI18OS9cqn3kfudHyzOkzydgLOejK/m1+VnQprBTPVA77yMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q//FzTwCzlgZtXhtnEDO8BvOYB72trFJURqERdK5clU=;
 b=D0NnZRsT7l0yO2F+NZGpJ5GglVYWvMJ2NTUa+nJBoJzftNV87M0st7WY+pbaT0YffNqc7+DjGwFWZoAEPbKL0X4ggVMLBCEryTTIBPrlrIAT+YAN1LvkUF47L/T77+L1/6NmtQKi8W+S/gUsWXwrVE3AhU67+RWoK/LPzMG8G9U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1450.namprd12.prod.outlook.com (10.172.33.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 17 Jan 2020 08:12:13 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2644.021; Fri, 17 Jan 2020
 08:12:13 +0000
Subject: Re: [PATCH] drm/amdgpu: remove the alignment placeholder for secure
 buffer
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579247290-16320-1-git-send-email-ray.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5ed3170e-b22a-7eed-0e08-69bf29770638@amd.com>
Date: Fri, 17 Jan 2020 09:12:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1579247290-16320-1-git-send-email-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::7) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [192.168.137.21] (37.201.195.117) by
 ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Fri, 17 Jan 2020 08:12:12 +0000
X-Originating-IP: [37.201.195.117]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d00b9c5c-acf6-41e9-cdc9-08d79b24f53a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1450:|DM5PR12MB1450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1450C399C11B574277422AB083310@DM5PR12MB1450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(199004)(189003)(16576012)(4326008)(316002)(6666004)(5660300002)(4744005)(6486002)(66476007)(66556008)(81166006)(66946007)(36756003)(2616005)(2906002)(956004)(31686004)(86362001)(81156014)(26005)(16526019)(186003)(8676002)(31696002)(52116002)(478600001)(8936002)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1450;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJ+KJn138afZlb8bA1L69/jE3iXKwlOXNM9WQghtbEBc56HvME5LMJTyDs+dp3wzLal8jZA87L24+5XAdSa9TisGOuNSTDjOdbggI3xIsmmGxW5zLRU5HMLJIwt2ng/z2/4x3vwYCMFutFgkOAhnoGRcYu5kOat4iRHNziOQd7gYt2HpAh45RJkTy/sTpLVXuYcs1wpZkjslzZO3+PIzDV7VPnRmcYYcAfv/sLXhft+r9UMKhs50jYKn7b1cmIZ/xy8T6222NOGMOuWj4tfoAqmBT8wCw8Jf3WRVxQJZvXr15LpJA0MfhRCUSrXi/j5c1FZ4iGy2rze9PaA1Lwh6UHylI+e48PbGImj9QyixEDdF8dXDTFRdZYmPDoA+VSUpv5v3WvYZhuCkTU1LQ8qIhHQwiNqJ86JIGUO+gbzmwyIza/JRcA7uH1ToAVdthuO3JLvVYxn8za10lnbeX5Z5Mg34m4tXWQgLzpRzzPPOBw2qzrNPgqJd7sBJ2hMwQeBq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00b9c5c-acf6-41e9-cdc9-08d79b24f53a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 08:12:13.3453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSSL3hb8fghIpTEdqpV91no8mdh9orIinhKDRg+25tb+ISruLii5SCimjXkUjU3/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1450
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTcuMDEuMjAgdW0gMDg6NDggc2NocmllYiBIdWFuZyBSdWk6Cj4gVGhlIGFsaWdubWVudCBz
aG91bGQgbWF0Y2ggdGhlIHBhZ2Ugc2l6ZSBmb3Igc2VjdXJlIGJ1ZmZlciwgc28gd2UgZGlkbid0
Cj4gY29uZmlndXJlIGl0IGFueW1vcmUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJh
eS5odWFuZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2VtLmMgfCA0IC0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+IGluZGV4IGYzOTAxMmUu
LjQxZDQ5YTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dlbS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4g
QEAgLTI2MSwxMCArMjYxLDYgQEAgaW50IGFtZGdwdV9nZW1fY3JlYXRlX2lvY3RsKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsCj4gICAJCXJlc3YgPSB2bS0+cm9vdC5iYXNlLmJv
LT50Ym8uYmFzZS5yZXN2Owo+ICAgCX0KPiAgIAo+IC0JaWYgKGZsYWdzICYgQU1ER1BVX0dFTV9D
UkVBVEVfRU5DUllQVEVEKSB7Cj4gLQkJLyogWFhYOiBwYWQgb3V0IGFsaWdubWVudCB0byBtZWV0
IFRNWiByZXF1aXJlbWVudHMgKi8KPiAtCX0KPiAtCj4gICAJciA9IGFtZGdwdV9nZW1fb2JqZWN0
X2NyZWF0ZShhZGV2LCBzaXplLCBhcmdzLT5pbi5hbGlnbm1lbnQsCj4gICAJCQkJICAgICAodTMy
KSgweGZmZmZmZmZmICYgYXJncy0+aW4uZG9tYWlucyksCj4gICAJCQkJICAgICBmbGFncywgdHRt
X2JvX3R5cGVfZGV2aWNlLCByZXN2LCAmZ29iaik7CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
