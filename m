Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1900C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 11:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9499561157
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 11:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9499561157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48ECB6E7D1;
	Thu, 27 May 2021 11:54:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC976E7D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 11:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLjUnVDwonAFsdggIX8Qzm3Sxplw4vO0QQ7D23I/3rIvDWvSddu7CBxflDZyS22lWyuuRiZrw+/lUnl0lCgCv9IBkKKvO8oIp2HwSqA1VIwX3sjGSVHcZ4baXPQyMWWY82mLsA5Ir5RlYHcpiI5qvoEuJ8sP1DveAJ4xnKmSScLmpJ4gRjo5fj4kPGYQ1CFBtf7JM4Y5mCU8FZAWbZV5FB3LKaINS3t/WbL/1oW+IVeWBbM5ytUcSrLVEnUFJ5W2Iha+lpUxsq2h/CocaXLRGRJXin5y+WEpa3Z/VzZijz/nM2sMZovPdQ1VhE7QNbJplAKw+lO0sxxkH7M08QOsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR6nFvkDE2E1thFJmrMKN9A0gPFHWy0u3zNicwOiuyQ=;
 b=VyBJZVygI6HLSteOMcgfZYr5pA/RwMza6uTMfHT9BNFa1lBMCd2z7fRpBuS/CVyDg7q9mZzLqzWu5RanTfXcCUyN5M9It7IaJ3lTmiM48nvhOrRA3zFsn/Zj3dC5TclTusewdmR8nPwCHW8VL7XWoZXzlqixrPAlPJd5HoR7+HVb0Ty1cHix6+YAQ68uWQAcNOC2GnRrjxIT3iUib/gVY0B/1P0i7oGUbP7Urvs0XT/4tuAcnRQljp5L20hJ4q9jY/tTyfjQp0css151Ac6hjyrcYFHfAO8C5stYRCc3RUI5b4dv+5AF83OTF97wvXOhSTvWMglJlzSzTCqxGIHZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR6nFvkDE2E1thFJmrMKN9A0gPFHWy0u3zNicwOiuyQ=;
 b=kFtG7r29d78ynzRBLFwiV3/4ueI+uvGquIM27AtctQ9EScpZUEcXOxIVw3Pz28YkSBZUrDlrcpxQ/JIMWM5V4hV5NiCJ30U/fkBB+VZ1lfE9OiL3DxCKfao9Pw2DoNONZFNoLfDI5cfy1TnooLDMmVbrg/8dWQWSG+u4zlzYon0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5536.namprd12.prod.outlook.com (2603:10b6:5:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 11:54:00 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 11:54:00 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdgpu: add amdgpu_bo_vm bo type
Date: Thu, 27 May 2021 13:53:38 +0200
Message-Id: <20210527115343.20133-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.111.109]
X-ClientProxiedBy: AM3PR05CA0123.eurprd05.prod.outlook.com
 (2603:10a6:207:2::25) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.111.109) by
 AM3PR05CA0123.eurprd05.prod.outlook.com (2603:10a6:207:2::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 11:53:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 617f1b82-77c5-4a1a-0e32-08d921061d72
X-MS-TrafficTypeDiagnostic: DM6PR12MB5536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55361BA508DCAEC506F651CE8B239@DM6PR12MB5536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTwcPbVV1DEktXUR3gh3/m3Ox1RU6dAf0zh0Vz5saxQ/kNixMVWP2rL6wK8jaUP2g9z1Mn2qFCojeeGyy1ARYQpQeekpxB6ayCgi64pP+tgxUodZE73NvXSmgFlkarUg8yIGhzInxjVg4/aE49KDsHAfs2qZJ766j1hoqpX9AvDcVRmK8Bfcdy6lrZ0KnLa/pKYUMyaHYyes8CqAu0kHWOJilQLbBiiEAw/eTqaBGYVnKfwISP9z/QRvbIDYOpxNVNPYxzRDc3f3PypTccdNSw70FQuC+g+/bE0g6y1uIFdX39cB4pALRE3djOp9EmTvBGwJYpQHe+9lW5mvjfIaEuZte59or9Z0QnImp4FA4fZwaFsKZd40+K/4tGXIi/bAIXNnHG3UEGcoWL8reURRkl5amqadBxbhX98w9MvXrvsASSLqZndgYWMeawQWA4MckNTmSgMYf1qkp37t6d5/e1CSxWtFnkpVkXW2WAwkaQItrtCIxbJBloRlwuSsWAxIgvLnY5aAhxDR+iJZJd3WkoraffruvqnNm8QoX12ph3PEaGswyQ2igWfBtJedeuce8ajaG0IOy2WjvobR3IWFRGJo2uGOo5nYJz895BGfkGbxm86Miv+bHm2FJ3sVYfnNlYGqF7nUWHufr1YU/1JliQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(478600001)(4326008)(6486002)(8936002)(2616005)(38350700002)(6666004)(38100700002)(16526019)(956004)(316002)(186003)(6512007)(44832011)(5660300002)(86362001)(66574015)(83380400001)(54906003)(2906002)(8676002)(66476007)(66556008)(6916009)(1076003)(66946007)(26005)(52116002)(6506007)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OU9tT2dyL2dHUjJYblAzMkF3YVpicGVwdVkzMlNoMlZWVTdOS0ttYWZjL3hB?=
 =?utf-8?B?bVoxbTNaTDJ3T2phSVRGdHN0Z2N5UWMrVmxlR0FPdHdOdFFmTDNORkcwc1V2?=
 =?utf-8?B?eU9vbzdNdlg2Q3FINmd3bXlldkl2NzVnVmRvT1F6eGxxY2RUQ2NiejhJYlFj?=
 =?utf-8?B?WFRJSWNRS0FKQnoyZEl6VTdTUEpZN0hZd200VzNmZjg5Z3FCazlNcDNQTGhI?=
 =?utf-8?B?eEIwU01MMTlXQ2ZxOWtsL2N0Y3h2cWYrSnVKNFhnSXF2aHJaVmNZNlRNTEh1?=
 =?utf-8?B?cytpTTdtdTd0ODArWGZtZWs5WHIycCt3eVlKdWVzY3JLNk1FOUp2b3h3cDkz?=
 =?utf-8?B?cnd4eDlSV3E5MWYzc0YwNUZjbVN0Qjd0QlV6djNSMDJPWUZEZFRZZlJwRTk4?=
 =?utf-8?B?NUZQNndYWE1FRWFleG8yRFFaTGFCalBKTGlJNUMyYU52MkhRN0VSTHIrS205?=
 =?utf-8?B?TDdqMmJ5ZEVmYytiKzBtY3M2VkU2VFJsYkJBemJxRkZsN213R2puMnJYVzI5?=
 =?utf-8?B?aUtjeGwrWDYwdnYzcjZTZjVPeHlnTEREdFFDaWd6THpmcjJ6RW1WSmprZzVH?=
 =?utf-8?B?MkduTnR1Y2RONnplRVIrRFNuLzV1TStqQ0x0UmpFK0ZSY2xLQlUrcWp0NUpB?=
 =?utf-8?B?R1BUUGE0Ulh4WEE2cGxHcThTaC9qNnh2Mlg0Uyt5WGJhWWdKQXJRWmpuMnBm?=
 =?utf-8?B?ckRnUWM5cXU0MTRocHI3a1JybkM5UGJSM2pjaGtndXAwdWVTdzlhRkZVZFF4?=
 =?utf-8?B?U21ST1hMM2tBc2pvVE1qcWRla1FaaENhWFU1SXh3NndoWnBsZnR4TnBYeURj?=
 =?utf-8?B?dXJZS1YySWM3UE9XYUlTd1VRVTl1T01DaFVKaGM3TlAwd2c5K04zblg4eUdO?=
 =?utf-8?B?SDNsVnFxS1dZQ3dYZmNNRkwyYkU1a1UwYm9nUmh3Q09zanlRTXFMejlWRjln?=
 =?utf-8?B?cFE2ZTM4MkRlcUZtZWw1ZjA2bEJoMkk2dlVXKzVtNnJNSmR6SE55TmdaZHls?=
 =?utf-8?B?TXBTb25pcVlkVkQ2TXU2K0swbjdRbHcxMzFzRC9WZXI0Z3ZMNHJhYUVjSHJD?=
 =?utf-8?B?eXhQK3hLT2NzVGJPY0NicUxPQ21wV1BYbTBXRXJpQUYxY2dTMEQ2L0MrOW16?=
 =?utf-8?B?UmRYZVR6c1lrNDV4bEcxZ2RpbnlXNnFxWW8ydTYwSFVCcWFvTnp1b2tnSlpH?=
 =?utf-8?B?QVdSSUs1WHhKNEVGMkpvd1VQOVdBN0d0dEVsMzJuMEFRUjdxdGxXcmZVUzhH?=
 =?utf-8?B?REtMejVnYU5na3hoNUhGSExXc3pUUkVrKzAzWGMrQkJCYUVZM2JsdFhSakE0?=
 =?utf-8?B?L3YrRFdZUHA2WXQ5OFdkTEZvY3QzdzNQVCtidTdHQmJwZC91QXMzWEdYU2Zp?=
 =?utf-8?B?ekNYRU9zcXJ5NWFYZFplT3lOYVRaUGpqdXhKeEhaTXhTbVNSK3JxVktFUFV3?=
 =?utf-8?B?dHFzZnNSMDJZcktTMFF6cTdDcE5YckVtMklDZURDdGtjd2dEWmJJVU5HbWxR?=
 =?utf-8?B?WVU0dE5OYWUwSUhlSk5ZUGlYYWFXUFduMnJKaE1VVHFDaE1uQk5rMEpXV2pr?=
 =?utf-8?B?QUdwK21RWnlHWmV5OXB5ODU1eGVKYmIvdzQ1SmJ1ZGNwcDFmczhDNU53Ykw0?=
 =?utf-8?B?UlFQUDdCdjNvTksxck82Q2JQRGFZZDJQYmplK0h4N1JTeEFHbWo1ZjUxTGlo?=
 =?utf-8?B?ZUpDelAyMytzVW9QWk8xSW81RmlMSnFNdjRiUTdyallSU2d1eWx3bmExdzdQ?=
 =?utf-8?Q?AS5KguR4OseTp7Z0uoj0XpnWFqVqN2xWgGkVi0E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617f1b82-77c5-4a1a-0e32-08d921061d72
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:53:59.8205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTZSOfkBNdVzdsqW0PZJ1M/MOskV2DIZomWOHxfTxNNhcDAKSOBe1gh5zSEHM4Idp1LEXXhiMZUliiitQSSV0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5536
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWRkIG5ldyBCTyBzdWJjbGFzcyB0aGF0IHdpbGwgYmUgdXNlZCBieSBhbWRncHUgdm0gY29kZS4K
ClNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAzMiArKysrKysrKysrKysr
KysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggfCAx
MCArKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKaW5kZXggM2Y4NWJhODIyMmVmLi42ODcw
Y2MyOTdhZTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMK
QEAgLTY5NCw2ICs2OTQsMzggQEAgaW50IGFtZGdwdV9ib19jcmVhdGVfdXNlcihzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKIAkqdWJvX3B0ciA9IHRvX2FtZGdwdV9ib191c2VyKGJvX3B0cik7
CiAJcmV0dXJuIHI7CiB9CisKKy8qKgorICogYW1kZ3B1X2JvX2NyZWF0ZV92bSAtIGNyZWF0ZSBh
biAmYW1kZ3B1X2JvX3ZtIGJ1ZmZlciBvYmplY3QKKyAqIEBhZGV2OiBhbWRncHUgZGV2aWNlIG9i
amVjdAorICogQGJwOiBwYXJhbWV0ZXJzIHRvIGJlIHVzZWQgZm9yIHRoZSBidWZmZXIgb2JqZWN0
CisgKiBAdm1ib19wdHI6IHBvaW50ZXIgdG8gdGhlIGJ1ZmZlciBvYmplY3QgcG9pbnRlcgorICoK
KyAqIENyZWF0ZSBhIEJPIHRvIGJlIGZvciBHUFVWTS4KKyAqCisgKiBSZXR1cm5zOgorICogMCBm
b3Igc3VjY2VzcyBvciBhIG5lZ2F0aXZlIGVycm9yIGNvZGUgb24gZmFpbHVyZS4KKyAqLworCitp
bnQgYW1kZ3B1X2JvX2NyZWF0ZV92bShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKKwkJCXN0
cnVjdCBhbWRncHVfYm9fcGFyYW0gKmJwLAorCQkJc3RydWN0IGFtZGdwdV9ib192bSAqKnZtYm9f
cHRyKQoreworCXN0cnVjdCBhbWRncHVfYm8gKmJvX3B0cjsKKwlpbnQgcjsKKworCS8qIGJvX3B0
cl9zaXplIHdpbGwgYmUgZGV0ZXJtaW5lZCBieSB0aGUgY2FsbGVyIGFuZCBpdCBkZXBlbmRzIG9u
CisJICogbnVtIG9mIGFtZGdwdV92bV9wdCBlbnRyaWVzLgorCSAqLworCUJVR19PTihicC0+Ym9f
cHRyX3NpemUgPCBzaXplb2Yoc3RydWN0IGFtZGdwdV9ib192bSkpOworCXIgPSBhbWRncHVfYm9f
Y3JlYXRlKGFkZXYsIGJwLCAmYm9fcHRyKTsKKwlpZiAocikKKwkJcmV0dXJuIHI7CisKKwkqdm1i
b19wdHIgPSB0b19hbWRncHVfYm9fdm0oYm9fcHRyKTsKKwlyZXR1cm4gcjsKK30KKwogLyoqCiAg
KiBhbWRncHVfYm9fdmFsaWRhdGUgLSB2YWxpZGF0ZSBhbiAmYW1kZ3B1X2JvIGJ1ZmZlciBvYmpl
Y3QKICAqIEBibzogcG9pbnRlciB0byB0aGUgYnVmZmVyIG9iamVjdApkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCmluZGV4IDExNDgwYzVhMjcxNi4uYTdmYmY1Zjcw
NTFlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCkBAIC00
NCw2ICs0NCw3IEBACiAjZGVmaW5lIEFNREdQVV9BTURLRkRfQ1JFQVRFX1NWTV9CTwkoMVVMTCA8
PCA2MikKIAogI2RlZmluZSB0b19hbWRncHVfYm9fdXNlcihhYm8pIGNvbnRhaW5lcl9vZigoYWJv
KSwgc3RydWN0IGFtZGdwdV9ib191c2VyLCBibykKKyNkZWZpbmUgdG9fYW1kZ3B1X2JvX3ZtKGFi
bykgY29udGFpbmVyX29mKChhYm8pLCBzdHJ1Y3QgYW1kZ3B1X2JvX3ZtLCBibykKIAogc3RydWN0
IGFtZGdwdV9ib19wYXJhbSB7CiAJdW5zaWduZWQgbG9uZwkJCXNpemU7CkBAIC0xMjUsNiArMTI2
LDEyIEBAIHN0cnVjdCBhbWRncHVfYm9fdXNlciB7CiAKIH07CiAKK3N0cnVjdCBhbWRncHVfYm9f
dm0geworCXN0cnVjdCBhbWRncHVfYm8JCWJvOworCXN0cnVjdCBhbWRncHVfYm8JCSpzaGFkb3c7
CisJc3RydWN0IGFtZGdwdV92bV9wdCAgICAgICAgICAgICBlbnRyaWVzW107Cit9OworCiBzdGF0
aWMgaW5saW5lIHN0cnVjdCBhbWRncHVfYm8gKnR0bV90b19hbWRncHVfYm8oc3RydWN0IHR0bV9i
dWZmZXJfb2JqZWN0ICp0Ym8pCiB7CiAJcmV0dXJuIGNvbnRhaW5lcl9vZih0Ym8sIHN0cnVjdCBh
bWRncHVfYm8sIHRibyk7CkBAIC0yNzIsNiArMjc5LDkgQEAgaW50IGFtZGdwdV9ib19jcmVhdGVf
a2VybmVsX2F0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogaW50IGFtZGdwdV9ib19jcmVh
dGVfdXNlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSAgc3RydWN0IGFtZGdwdV9i
b19wYXJhbSAqYnAsCiAJCQkgIHN0cnVjdCBhbWRncHVfYm9fdXNlciAqKnVib19wdHIpOworaW50
IGFtZGdwdV9ib19jcmVhdGVfdm0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCisJCQlzdHJ1
Y3QgYW1kZ3B1X2JvX3BhcmFtICpicCwKKwkJCXN0cnVjdCBhbWRncHVfYm9fdm0gKip1Ym9fcHRy
KTsKIHZvaWQgYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKHN0cnVjdCBhbWRncHVfYm8gKipibywgdTY0
ICpncHVfYWRkciwKIAkJCSAgIHZvaWQgKipjcHVfYWRkcik7CiBpbnQgYW1kZ3B1X2JvX2NyZWF0
ZV9zaGFkb3coc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCi0tIAoyLjMxLjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
