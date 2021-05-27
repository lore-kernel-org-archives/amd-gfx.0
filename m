Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677F0C4708C
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 11:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257C561157
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 11:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257C561157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D4B6EE91;
	Thu, 27 May 2021 11:54:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA8F6E7D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 11:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmxWXncmZQxXk5M5uTH8a0wXMJDlV4Mx2UwjmRr1wOc76IW8d7tfb73Rl4KE2wzmD2eK2cN5RKxOkCSfhDia4FFIXq1U1RO+cqBEkjJT//U870p5vUJKLd9FbuTKLkF45Wdq0zQBhHUQEMkKyWRJIpNu6fJjo0y15Qw1NEhJ87Rg6fa/P2DctM8WUNjyWsP/gQR8cAs8P4TLoiE40Fmzm+63Krw2uMDo0h2ejvHPClB6ruuMcmvytRyz8QHSHuTO43DcH03G+fieL3G5ASgWNo7rwkf9qCdULIH4Ev+RkezoKF//e3IBGVCP/ZqZpHwflA8fj+MxEOJ55X+qth1c2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LdD1mvlb4xa2kTjY1plxX5HhsXrgnJBaKfS61Hk8MY=;
 b=RzoiyQppgFxFQgoZ+GoZeOQ46BLE9M+wcQ/NZzifOy1nW05PPHZ/vL6TJZaByJ45asgIL9FkPDmPbPJnlvo/SHIafWNs2JiTPb8bZb+oqSDPX31LEO9TVcifBVVii5cnA9V0D9XO/rTq/zpS0/oNdzGyJiNfD1Ftzs8Zqna/bIQgWiezv2OLdlp6w0lzrcFNO6iaOot9D25g4aVeRHtFKiaSJ3R+pZUQEimzVPR9gF8hx5Do2UzVPxA9FiHTMK33iWAYl0r85UzekvtfaLalCkwC4bV9Xi61a5qwg7Dv3bPioXazcgYO221rlg+++tSCx7RDhTUb/iSQQ6U6oDrfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LdD1mvlb4xa2kTjY1plxX5HhsXrgnJBaKfS61Hk8MY=;
 b=WoXMOipOA7GLcCH1sbIuzUIhbPrN2QMWnZWKYTbLQheHRbIyfUViFql09zmuvjywlqOrjzc2/X91Hnm+i/j9y1/kIi2BKVRUisGXILw9iA4eXhAooo7xpU2ekbREOH9mOwmiqAmKxh4Yc4/7FapW+uOdPtK2cBkgUfEatGg/Hj0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5536.namprd12.prod.outlook.com (2603:10b6:5:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 11:54:01 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 11:54:01 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/6] drm/amdgpu: move shadow bo validation to VM code
Date: Thu, 27 May 2021 13:53:39 +0200
Message-Id: <20210527115343.20133-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527115343.20133-1-nirmoy.das@amd.com>
References: <20210527115343.20133-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.111.109]
X-ClientProxiedBy: AM3PR05CA0123.eurprd05.prod.outlook.com
 (2603:10a6:207:2::25) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.111.109) by
 AM3PR05CA0123.eurprd05.prod.outlook.com (2603:10a6:207:2::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 11:54:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5520eca9-196c-4e86-903e-08d921061e30
X-MS-TrafficTypeDiagnostic: DM6PR12MB5536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB553652CC520A4054CECEAEE58B239@DM6PR12MB5536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sUTD74beIedfoYecIXCz/79TVx944oNeXsUqp69gnpCfQmRsv5IjNj4qwJeDqIuP3ELLG6cHK/MXqok9rvXmHkuDGcA0tjLrQ9Fv8ecf18xqeJrRd6vI+WTe02YLlJRHG5C42ewHMV1dxQ2RIlrY3Jx8C/wnCmVSgM263cIcyVr/nNNQcsFUkXd34y6A/96fBL+VyM04W5xz6hYJXnPulpDHLVjkcsN+Z9Vev6P+amcmUWJrfImgZZyG3Y+lRF4GLvqTl61xDa/CBuXy0d2IWHlOiwSUsJApuWxGOayioAjNPMNYm1WXr1YglVE9wdQQMicOii/adxHMBgETIVHbpyouIUIq2W2X3E1jn0BgaZ7FH3d0g5mNsAdf5+7BygOI1Ll8lq0aHiqsAPSlI75unuiF3UiBl/+xglCdFpt9YiVpepyTL05KABIe5sih6MFo6wxFIA+wI6HrA2m1UuQeAfKcb943bfmDvKpkMj7koJ2580TsoFlqpXtpkRfgFXtadDV9THktwG9I8Z1y6DKxmJ75nMW37GEZjQ/RjRvli25kJUZaF4zcBmhshO/w1bicJTyqMYOt9i5EeHnEh1DgCAci3M3M7UUta3wyRu0ifRw2cyxsGV+ZFNHm4Dla/WMSFRzI5uuTKWmONiSH/RtdGjFfIAU0R71v/anmfKZ2YA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(478600001)(4326008)(6486002)(8936002)(2616005)(38350700002)(6666004)(38100700002)(16526019)(956004)(316002)(186003)(6512007)(44832011)(5660300002)(86362001)(66574015)(83380400001)(54906003)(2906002)(8676002)(66476007)(66556008)(6916009)(1076003)(66946007)(26005)(52116002)(6506007)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZERsTWd2SHpNZXNqaUY3SW9BdjJEQWwzUlozTTJKVW9NVXhLTGlQaTA4eWdV?=
 =?utf-8?B?VnREK2NUdHA2WEpjM1ZCWkJQQ1oxb1lYS0NaR0grMjh2MCt2VzByWWlvMjFz?=
 =?utf-8?B?SFl0Q1lUcFNJeXoyeExpV29tbFB4SVpHZVNKcXRwVXdOOHFVNHdaQlJEdXVE?=
 =?utf-8?B?LzdBUC9SVWxDOW1zOU5kZ2V0S29FZFBINTZ0am9ITjBlUnNKeHVYMnRSekNt?=
 =?utf-8?B?cCt0dllrbTRCa2pGZXJKMENEQmxaSlprckc4VjJpRURhT2QxNFA4S2ZteER3?=
 =?utf-8?B?TEV3WjBDZnFJK3JHcXpJQVJqblBzUHc3T1BnVjNUeXZ5dzJ4UnhvV05XdmNW?=
 =?utf-8?B?RlVudTFRVnNPRndvYjJvcEpyVHpSOEZJYzFITysvYW81dVJnVzlObk5OckV3?=
 =?utf-8?B?RWJLeTFZVnFkblVza0t5NmZNOEd1aGNzbHo4UjlnZUROSCthOCtWRUhITi9o?=
 =?utf-8?B?U2lPcEJCNGVrZXBadkx4dkNscDJVQmZIajE1MlhjYlMvS3NaNzBjdWZUOWow?=
 =?utf-8?B?REd5eGw3K2JodkFPRXdpNGN6RHJORGdFUlRCM3BhR0xGTmM4eEl2cFd6cjZ4?=
 =?utf-8?B?amExWjRaU0tCVlI0ck9QUEVsL2hsbmFQbmJmM24xcDhwV2IxWmUzOXFWL3lt?=
 =?utf-8?B?RDF5bVBLOTUxRXFydG82dkFra1ZPSnNVNFdZeDdJek5ZMGhBdzkycXllUW02?=
 =?utf-8?B?Wm4yL1VzVE84MFFHckY3MENBY09kMnhZMFNLYjBsdnBET242VlM5MFlnL0Uw?=
 =?utf-8?B?MWFLMmErejJDRHRKZXo0N3pOMUNwSkhvNGVhY1lwQ1gvL0w5b2F1YXR0Nm1Z?=
 =?utf-8?B?akROeFdUcjQ4M3JwTU1ySHNvT0NEcUVydjhFOFM1WFFuRkl1TndRdmYvSWtL?=
 =?utf-8?B?ejhuS0JKNElTNW90K2xQS0NUSlAwZitKc0VLWlZ5MzdWamN5WnQ0TCthSThv?=
 =?utf-8?B?NzVoQ3BUYTBUbVh6Ry81WCtMNnNtT21oaklGQmxlUnRjU1NrY2NsZjN6b0hm?=
 =?utf-8?B?UUpkbmhNVEtYL0t2aEMzdzB2d05NOUxHK2tPSU5KdThYVzNaaHAySGtQUCta?=
 =?utf-8?B?c3lpQjVQN3ptR1NRNEpQVFNZYm13QjdGbDhNZmx4MHhDWXoreU5FSk82eTdx?=
 =?utf-8?B?amdlYUpmcjh5WXB1ZFlKNDcxTForbWZJOXJIN0ZrS0JjcHpoNzlldUdVdW0x?=
 =?utf-8?B?NUxqbUVFYXNTNDZnMDIrd09QYWdvRlJxYkM2WHF5UGRQQlJ5VGxFWVYyeVpT?=
 =?utf-8?B?aUJ0ZDJUUVpBMzVTSmwxM1p0bFYrdzBkRkEzd0tnV1hSR2JrRGs3elBTQTFj?=
 =?utf-8?B?M0RPekZYMWF5cmxxZyt0eDF2VGJIaFgrL0ZmTXdvdnZkY2x6aVg1cEcxTmxP?=
 =?utf-8?B?TGFvWHZoSE5PWm5xUTMxYlNHSHpLREF5Z3hNTFFhd1hPcEhqalBIOEladGxL?=
 =?utf-8?B?WW9HVU5nNzBwSW9QUCtoRXhhT0JsVEc3bXVjMTFHNytJYXdia3lKaGNQbnBE?=
 =?utf-8?B?bSt6V2hyZnJwRzFqMW4vNEl0QlJSdmdUR0hrbEtiK1ZlREtYek9GbTgyejZ0?=
 =?utf-8?B?S3ZmRnY0NUlqVjFpR0VVeTdUR0RsZFVEUU1vZ2dyNHBpVmtzeFVaVmhkZWVT?=
 =?utf-8?B?MXlkcWwyMllmUlNFNzNtTkF1YTNOTlo3U1JENlhPSDZSckRuM3J6M0x2UWkw?=
 =?utf-8?B?YnZMQnBNZlVjaVpvWnlLaGl1djBBK0V6ZjNSMU4wTmMreXRnSlBzS1JhUU9s?=
 =?utf-8?Q?mttPLF+y0ywikibOJFbg71vbSYy/1g7oKWUibFp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5520eca9-196c-4e86-903e-08d921061e30
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:54:01.0840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wiptsz8V+SAtC6/Mr05gLyuu6gOPqNcMoNopwk/f2hsuY0PlRxe+bGwV4CPqBc6s756Vnm5DFgAGDjwtf+leg==
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

RG8gdGhlIHNoYWRvdyBibyB2YWxpZGF0aW9uIGluIHRoZSBWTSBjb2RlIGFzClZNIGNvZGUga25v
d3Mvb3ducyBzaGFkb3cgQk9zLgoKdjI6IEZpeCBhIHR5cG8uCgpTaWduZWQtb2ZmLWJ5OiBOaXJt
b3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2NzLmMgfCAyMyArKysrLS0tLS0tLS0tLS0tLS0tLS0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2NzLmMKaW5kZXggOTAxMzZmOWRlZGQ2Li5mNmE4ZjBjNWE1MmYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCkBAIC0zOTYsMTAgKzM5NiwxMCBAQCB2b2lkIGFt
ZGdwdV9jc19yZXBvcnRfbW92ZWRfYnl0ZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHU2
NCBudW1fYnl0ZXMsCiAJc3Bpbl91bmxvY2soJmFkZXYtPm1tX3N0YXRzLmxvY2spOwogfQoKLXN0
YXRpYyBpbnQgYW1kZ3B1X2NzX2JvX3ZhbGlkYXRlKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpw
LAotCQkJCSBzdHJ1Y3QgYW1kZ3B1X2JvICpibykKK3N0YXRpYyBpbnQgYW1kZ3B1X2NzX2JvX3Zh
bGlkYXRlKHZvaWQgKnBhcmFtLCBzdHJ1Y3QgYW1kZ3B1X2JvICpibykKIHsKIAlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IGFtZGdwdV90dG1fYWRldihiby0+dGJvLmJkZXYpOworCXN0cnVj
dCBhbWRncHVfY3NfcGFyc2VyICpwID0gcGFyYW07CiAJc3RydWN0IHR0bV9vcGVyYXRpb25fY3R4
IGN0eCA9IHsKIAkJLmludGVycnVwdGlibGUgPSB0cnVlLAogCQkubm9fd2FpdF9ncHUgPSBmYWxz
ZSwKQEAgLTQ1MSwyMSArNDUxLDYgQEAgc3RhdGljIGludCBhbWRncHVfY3NfYm9fdmFsaWRhdGUo
c3RydWN0IGFtZGdwdV9jc19wYXJzZXIgKnAsCiAJcmV0dXJuIHI7CiB9Cgotc3RhdGljIGludCBh
bWRncHVfY3NfdmFsaWRhdGUodm9pZCAqcGFyYW0sIHN0cnVjdCBhbWRncHVfYm8gKmJvKQotewot
CXN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwID0gcGFyYW07Ci0JaW50IHI7Ci0KLQlyID0gYW1k
Z3B1X2NzX2JvX3ZhbGlkYXRlKHAsIGJvKTsKLQlpZiAocikKLQkJcmV0dXJuIHI7Ci0KLQlpZiAo
Ym8tPnNoYWRvdykKLQkJciA9IGFtZGdwdV9jc19ib192YWxpZGF0ZShwLCBiby0+c2hhZG93KTsK
LQotCXJldHVybiByOwotfQotCiBzdGF0aWMgaW50IGFtZGdwdV9jc19saXN0X3ZhbGlkYXRlKHN0
cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAogCQkJICAgIHN0cnVjdCBsaXN0X2hlYWQgKnZhbGlk
YXRlZCkKIHsKQEAgLTQ5Myw3ICs0NzgsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19saXN0X3Zh
bGlkYXRlKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAogCQkJCQkJICAgICBsb2JqLT51c2Vy
X3BhZ2VzKTsKIAkJfQoKLQkJciA9IGFtZGdwdV9jc192YWxpZGF0ZShwLCBibyk7CisJCXIgPSBh
bWRncHVfY3NfYm9fdmFsaWRhdGUocCwgYm8pOwogCQlpZiAocikKIAkJCXJldHVybiByOwoKQEAg
LTU5Myw3ICs1NzgsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19wYXJzZXJfYm9zKHN0cnVjdCBh
bWRncHVfY3NfcGFyc2VyICpwLAogCXAtPmJ5dGVzX21vdmVkX3ZpcyA9IDA7CgogCXIgPSBhbWRn
cHVfdm1fdmFsaWRhdGVfcHRfYm9zKHAtPmFkZXYsICZmcHJpdi0+dm0sCi0JCQkJICAgICAgYW1k
Z3B1X2NzX3ZhbGlkYXRlLCBwKTsKKwkJCQkgICAgICBhbWRncHVfY3NfYm9fdmFsaWRhdGUsIHAp
OwogCWlmIChyKSB7CiAJCURSTV9FUlJPUigiYW1kZ3B1X3ZtX3ZhbGlkYXRlX3B0X2JvcygpIGZh
aWxlZC5cbiIpOwogCQlnb3RvIGVycm9yX3ZhbGlkYXRlOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYwppbmRleCBkYTE1NWMyNzZjNTEuLjZiYzc1NjZjYzE5MyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTY5Niw2ICs2OTYsMTEgQEAgaW50IGFt
ZGdwdV92bV92YWxpZGF0ZV9wdF9ib3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVj
dCBhbWRncHVfdm0gKnZtLAogCQlyID0gdmFsaWRhdGUocGFyYW0sIGJvKTsKIAkJaWYgKHIpCiAJ
CQlyZXR1cm4gcjsKKwkJaWYgKGJvLT5zaGFkb3cpIHsKKwkJCXIgPSB2YWxpZGF0ZShwYXJhbSwg
Ym8tPnNoYWRvdyk7CisJCQlpZiAocikKKwkJCQlyZXR1cm4gcjsKKwkJfQoKIAkJaWYgKGJvLT50
Ym8udHlwZSAhPSB0dG1fYm9fdHlwZV9rZXJuZWwpIHsKIAkJCWFtZGdwdV92bV9ib19tb3ZlZChi
b19iYXNlKTsKLS0KMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
