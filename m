Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66E7C4708C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 10:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635AE611BD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 10:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635AE611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E34376E069;
	Fri, 28 May 2021 10:56:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DFC16E3E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 10:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ON49cfJa5Rb0JzAuL37vXLnVvtwpEmqRffu0nSJo/48ZxJhUptrsIrYuMb08OthjueVJPegKAfkJhXzahpXUT6mQfXA2zMhhRfKkClUKFhbXFslPJQD0/scoocvGCZ5xOSW2N1u45nf8BNmmnxA3693PqUhfP4w85L+4GfFD1pkK+2/wcCBHUMNYCWh9zN4RoBBXutWkoxIdtNGSwS+A4riIAXk7d0LhJ3lRZnu1rDvBoAm+v+So4lSxgXDFFnX3JsneDRDldUyCp2LDXFpTdmUFXke0aqF6NcZCZuAoMc5uZbh0CHu8oMt+LF56IIT9txlbdk4Er8V/arvW/vezFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d41wM6uQGDTlET3TSId0+clzBweUcXAWjVFzCJ4EjtY=;
 b=Z0lXIHw8gCyLMKQVkDxVPLlXVT690Ohtob7dtinXQViCERNkNSdU4fl3RyaGqovzTfwY+ddDS3/4Gre8NWCmNTtDSkB7bZJxQmQ6P2/nW99nnh0F14YstcA7th7dCWHSIBY+JwVkNyo5rl/k+N3USJb+yFNhe6PTsE6K2NaHErUUBziye4ylu6teexZf2CTtGU8ER81orG0ufnTU/ht2cjjJ6ckxOusNcQLCG9rm+2FWZOZI2JW/y664N9sVn1FFw+wbuXQzPkfri6AInTyrcDX9EH2Z4M/K45fJJ4qcbsbybExfztMrahYLLUKV33UBi+548tGkoYL53Hh5Y6SbbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d41wM6uQGDTlET3TSId0+clzBweUcXAWjVFzCJ4EjtY=;
 b=2arNQe/KkitRXZW26jc5zeswwRL2M/+I7WctrCZwLR4XYVyYS0u+4zs/KRyHrsKS3CROHlp8k+6HCwr3ZxjtxaONx6mNG/Pr1T3OljqLZPPtLLm9ZaQhfGr7vuuRHHr9Shtcmk7GdGFyhIJ3CUZcUp1fGcynPgta5oYhZkIQFu0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Fri, 28 May
 2021 10:56:39 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 10:56:39 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdgpu: add amdgpu_bo_vm bo type
Date: Fri, 28 May 2021 12:56:18 +0200
Message-Id: <20210528105623.28148-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.100.114]
X-ClientProxiedBy: PR3P189CA0081.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::26) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.100.114) by
 PR3P189CA0081.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 10:56:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dddd3fd1-7aa4-44aa-4e90-08d921c744f6
X-MS-TrafficTypeDiagnostic: DM8PR12MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5416B568EBADE39982DE39CD8B229@DM8PR12MB5416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bsYbOc8qDzgt/riEMPulDkYdhT3rnCtntZZ1Q/JSo4O/kR7a1pcZW+2xsnfr32bj4CNQj2NZ0Iu2OGJgQ6EDgeESxIFjikTdzx10Hl3tmzzO6FrGKhDZfJS0nqSTMHF3grtXJ/NUSYfq/WUO3Bgq2u3u9w/k0F8gNpqnQyepDnKVyitp5kgCA0qoBz1P6qlfzBYhbq0vE7UC1aGnIfCZtlJ+fQUxkBS6RCJPWvUhAxSFaOkVdHOqeoFOeOtt818m2mSSPr4qQ8VV72VBHRnYzr7ujsZSwkJj3cLaSlNDenoX7I9So0ZQo+zAqw9YTU7zTzJQqlW0f3dXSXU1a5429jLnEBLwZdDlxxv8hfJUvwR/CNoyPmsvbl1wsrkd1h5j++ir92qBIREmRkJfb9u4HkDA8mkuy/l/jREsyrrldfRM8DUMLc9zt+p3exSc/bxYzqnhz1jVM1N4M7g2e0+tLu0ufWpD4g49id50gRDtynIZH+7NvHWAnWbA2s+m+KJd3e8bmswRipry0UFH4Ssq7AqiMuvlwRGn9B9397fsUqIxcx1qbeO7WOsj97iwYy7IN/ax4RWWjgX3s6sB8YB37TFugn4eG6+vydeJXrm3cUnfUwm3Q+Z7IpHbDUYRwMDy0MJWmYJzBVgFiRBBiynNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(6486002)(2906002)(6512007)(38350700002)(38100700002)(6916009)(36756003)(44832011)(16526019)(5660300002)(66476007)(186003)(66556008)(66946007)(86362001)(956004)(2616005)(26005)(8936002)(83380400001)(66574015)(6506007)(478600001)(52116002)(1076003)(54906003)(8676002)(6666004)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bU9XL0xGZGxLTzNOQUVVRWhPV3NTUjVCZG9MQ3g5OVJncU52N3NoSFlWNTNY?=
 =?utf-8?B?SEVPNUFRbzB3Rncwa1Z3aWR4RVVlUmZJS1JHSUVvWTJ3MmdTYk4rMVF2SnhG?=
 =?utf-8?B?bVNrU0dJOFo0Qk9scWJiOHgzZXpYeEtWelpwYVJYK2pzTmlGaHlYeWY4bEhD?=
 =?utf-8?B?QUhJUjdCVlRUZFlQT2NPZUFnNXRZNW9CUnYrT1laTkNXbkRZdFQ4TkQwZEhJ?=
 =?utf-8?B?bTNCdGVmbHVmVW1NdGE5Zi9Pdi9kWWY1QkdZTldnZjFJMEREQ2RtRVBaSWZ1?=
 =?utf-8?B?Y1QrV2I4NkVSZFJ1bWtPUGVReE82bTZjd0ZDcU1UbEthajAvVTNnVjRGbXRY?=
 =?utf-8?B?LzhJREpJYlJuMjdzcWtoSE5Bd1FQa21ubnZFMndtRUlVek9XK3JzQndvZi95?=
 =?utf-8?B?RU9NajY3VFJJazhPOS9WM0hZYVp1T0NQVDNGRzI1NzMxZzM2ZnRTbFZubUVm?=
 =?utf-8?B?TmFESnZtVjNXaEVGZTg5dHQ3VFFacmdQRHdWM21WcW1JMG5BbUVISXB2NXpN?=
 =?utf-8?B?VWZLZHJNakxxUThQTk9aQlFQOHBMTnRxMVQ3emY5MmtUcEdMSFBaUUhQazBx?=
 =?utf-8?B?Q0tpZjJlU1ZoM2dMUmI3K2NvYUhHK2VSeTlJTlprLzZzYllLbTNaNXJIdTNG?=
 =?utf-8?B?TzlqT05CRWgvejlMSjJ0MG1DdnhrUGFPL0VqZklnYm96RnhlUE4ydTFzb2Fv?=
 =?utf-8?B?cXdUd2xaRTVGZjlxRzlQaU0yVE52ZVJGTU1GRERFbUhTenJIYmhISDFqdFZ2?=
 =?utf-8?B?Tkh5TExyVUFQazRFeUJtLysxUk1odFR3Q2ZicU0zZDNEcDZ2UzFKZXE3T1N2?=
 =?utf-8?B?NnFOOWhKRDJ6Nm9XMHpjMDdsVzc4eHc4VjBoajBJWHB5Z3JPN3p6czNjNUM5?=
 =?utf-8?B?dmlaSXlvdWVyeVI1cmhoTjZpbGd2K1J1S05VVFdKQ3dkQVFpNktnNmRkdGtm?=
 =?utf-8?B?ZVV2WnUwNk5WUTdKM242OWw0Uk15bGtLRHA0Qno3RGJhVngrVXFjNElmUHg1?=
 =?utf-8?B?dUxzUnM0WG44aytsQTBvV2k5cmdMQS9CSDRFMk9TQWxsRzl1anFSNWZzTCtz?=
 =?utf-8?B?bm55UXBuRlpoZUNiRUlMTzBqUmVEeno0WkxOcTJyVENrVjVkK0ZZSHpDU0M1?=
 =?utf-8?B?c0FidmNUV3BjUGJlMG9kajBNYjVUbHVXVmQ3d2lKVUlzTDhLbzRnMU90R2RJ?=
 =?utf-8?B?dmNxNDMyMGNvWk9sVUVFbk02bDEyclhiU2hJTzFlMDRRT3JEOEVuT1I0b05W?=
 =?utf-8?B?bHg2R3F2QWtCQnV6eTUwZGl1ZW5PZDY5aUtiT0dNcjNDRHNod2NYV1Bic1F0?=
 =?utf-8?B?NmZUWk14WnFaYm5TUWE5QnQ0bms0Yi82RDA2K3NrUmdqNVJ3bXZ6NzNqcldl?=
 =?utf-8?B?WkRydDljcy9McURqWnZlcjJrNVAxQ3JFQVk2QnNZbEMvcUwrdkhtQmxVWWJF?=
 =?utf-8?B?SDZCbU9lQkdaTTE0Yi9PUEdGSEg3cnBRbzg3QzBiVGxxWEd3OEJFNWZnN1Y4?=
 =?utf-8?B?SS9aYnZ2V3dvREhobkltRTU3aWJzR3o1bGxYU0Q5WDQ3d05lQ080YzE4R0Nq?=
 =?utf-8?B?SGpqK1JUclQvNE1sMkJxOXNGS1Njb0hsUTg4c3hKVHJydSsycVpGYXpQT3lH?=
 =?utf-8?B?N0lub0FrRHNJVHRXUjRMK3dqQnR5dmJKcGlMeFNjSlR0azRrOFZuZVc4RlBN?=
 =?utf-8?B?cEQvM1FBaGtSQkRuQVFNZE0rYTlOSVJoOHJmN1hnS3JpWWduMmhuNGRXZFhZ?=
 =?utf-8?Q?Q1XaRHIC5KQ5MZcBDK10ovnKKFXo5OncMg5v+fk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddd3fd1-7aa4-44aa-4e90-08d921c744f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 10:56:39.0897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kT6zPhKa06FtdAjFZYLH9pURQTTPy8wNMqe514BBmgpJwSal4c5laIsOBe+xMJQ66IidhoX9IJ490NBYi+52Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKaW5kZXggZTlmODcwMWZkMDQ2Li4yZTU0
MjZhYjI0YTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
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
