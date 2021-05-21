Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BBFC04FF3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 21:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547CF613EE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 21:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547CF613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6AB6F91E;
	Fri, 21 May 2021 21:19:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0CD06F91E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 21:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0utOfG/1UK3Vsv3ruDydw+M2Qv1P0Fqa+/gUd1tLnhvKoEK4yjwTo7Fd9OePCv2Jmcc+DsZjVo2Q+9pTrVS4eqOa9p2pdVnduFct20FG6x/rkpdt0TGB9G5qTQvDoEXv2/2jg3DzQzZk3DlprKL+1PD4FLJsqZXN0X4XDNpgYSmyK4OJYR0zYDf9Lcf4U051ymD8o8nEPskRhTiyIiGBIF95mjS3wmVQiyfIx5WTOP51GOeL4eiCSPWr6hAPEf5Sh1sC9Iaqt8AlN2uKM//EIgyLH7GlH6sFpzn0+73QZlhQTjV7NPsR0sS5fzuxevArUPVQW86KdcgdbMypyiruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thYq2Esz0vf37i10TbZnnuX1JIJipYyS9YLuRo1m3C4=;
 b=QQ0Uk9XGtiMN24cw8ZGyd9ieoqv76+JA5fFQBMBk6zTf+x76m50hls106kOaoZwzxVwlsFNurGPq12vczD8OBBu3oHJZ8YtM3iNkZF9TJzndXaV1M44nrnD8KDbQFCSIqN5TwM52JFOUUUyTAejn/ERrBtiRcV/fiMRC2qHv0erXyIb28IWoZ2AInhuyRsSOGzYlrsbfamtQeun6q2PLd8nVkuxah/LqJuSVNt8/JgRU4VEAHZQ9nucU0HR/NLRJP/EsY+EI0tPNsDNLrMqZNHT+wQX/19pbAW2mhlFGRNCFH9ksZq67S1T5S2J03bOa1gbqahN9ejGzSzsoj5eMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thYq2Esz0vf37i10TbZnnuX1JIJipYyS9YLuRo1m3C4=;
 b=vW+a3cTabr4fKVxoOEdtq6C0zHAszkQB/ZCAPzKjOwteWyd3EPVUiWRcnmcVUvynz15dZBF8Fzbb/b0Sw7+pf6+5jg/DNU8eC9P5sljhU05UbTHST2Cl9oqv31QjrR9U3WVD4M2XMw/v61OibbM634cK93FhBj/SoqtUkrY1TnU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 21:18:56 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4150.026; Fri, 21 May 2021
 21:18:56 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: Don't query CE and UE errors
Date: Fri, 21 May 2021 17:18:34 -0400
Message-Id: <20210521211836.4839-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 21 May 2021 21:18:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42bcad78-58d4-4a54-aab3-08d91c9e0ab3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45168FF996212656E8DF5A7499299@DM6PR12MB4516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/O0nDEEG1Hghi6eP1XGxaeCDsaZU1P+Ul99pIWuBlN+dWtHoA/01880nHqeZvObXix4IobfI6Su9pQ92cFtl8ygrEJ6H79bOWX55d37s/Umms4YJ9/wK3Ki98PoOrxTYmT6KHtQv+wWjxfHNnKzKQTTHYVhpD8b/ykxzEzAhWw+1xnk4m6P7xf6YRyLgz1lxl9IPHVJNGRBEvfjd6clxA/1+rgshHYe6IPeWsq69yRGliQtiCgdUT7TKmuOWB+tQOuU0BM6P8pKiowb/ivx7fL2kA8E3x98PQ5CoRJaTDZ8A4TlKwlNMC7EErjQoJFETM9TzcDooxdwHsah6JmP6Azx1tdXTp8Ci4EsZYMfbkgtudPZAXUh9JfrOHrVmY3W6BarBloZMdgdjtRvKvPaILNv8kT7vkLuNAjueS+Bmi2hqAxwrazHtqWjqG77X96kxekHcZgVeMCwFPkmpbMaYEwlkt5svmbRfA6QA2+8olVD+ANfdGx4X7k5Mu2/Rjae2j4KXQKpXoii4nbTz4wChiymYnskL9TBpLIHcUys6kUec4QbsT4Smkjv7mV/hwjAqKBYzP88yg3GVxS3vg5p0dU/crUhcD+GyDn/8shAqPNxDxVknrmnPE2jEFtWTP8h2CzeqYucG1MK8nILl3tZ1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(8936002)(2906002)(8676002)(6916009)(1076003)(66574015)(186003)(54906003)(66946007)(26005)(83380400001)(66476007)(6486002)(66556008)(6666004)(55236004)(6506007)(6512007)(316002)(38100700002)(52116002)(38350700002)(16526019)(2616005)(956004)(86362001)(478600001)(4326008)(5660300002)(36756003)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R2lLMUpLM0RQelFzZjVDZ09NREdGeXZ6ekw1dWRMWWw1TCtkaWxkOHhKZXVw?=
 =?utf-8?B?Wjd1RW1XdDRvK1JLbzlwY0U0YlBKcmJkVTczK0NXS2hCcFRpVEJ2cTlMMlZl?=
 =?utf-8?B?Qjd3NVdWODU4UE9oeVgyVGJ0aE94a1QxNVhyS3A2dnE3UHZpcXExVDBkSFdE?=
 =?utf-8?B?WER1d0MwTEJDM0FoZ1VqUW4yamhQNlQzaklYcWZKcTNqQWt5Y011c2gxakpX?=
 =?utf-8?B?MXZOQ2N5ZGxRM3dleWloQ2tGM3l4NFBtdlR2ajk4ZlRBTGhFUHlOcFBqWGt4?=
 =?utf-8?B?dkU3ejZ6dWg4ZFpkRDFDbWxpMnlyRVBEUEtYQ0ozd1kvS0Jra2ZrTnVzVEd5?=
 =?utf-8?B?L1NjRDlPTktQeFh5TGllNGltejJ2T2VmT2haU0QxSk5qejhycXpqMm9xazRJ?=
 =?utf-8?B?b3VFRU0zY3lPeGgrNzNKSDM1VGw1M0VNODBNYU91ZUpZMmwwT1B0Zy9CSUNH?=
 =?utf-8?B?cUZ4VExuUkk4SWxFTHJzREJJZTVlUXk3bzhIWElVOHN1NG52WGdnZUNEenl5?=
 =?utf-8?B?Q0R0M1lWRm1IME90eWhrSU1FdFc3ZE5qVTFxdUhuci9udXJBS1JITU9Vdk5r?=
 =?utf-8?B?N0Z1UUFLc0dBWDR2VzRFWTdNYVlUQ2gvRkd2MXJuUEh4c3d6UTA5eWtNK2ZJ?=
 =?utf-8?B?Mjc1MkRaQmxpRTBLUFJtRDlhNEUrQWQwYmV0QkdaUExkQWpwZ1ZIUVlqY1Er?=
 =?utf-8?B?c1U4bWEydFczVy8zdWsxams3YzdvM3c4dWg0STYxdU8xOHBVcTVtZjBiQlBU?=
 =?utf-8?B?RWowSE9lZ01MeDd2RHNTdVlUVVMrZWd0NEVjcTFYTFJKa3ZJZDkvRm95dndR?=
 =?utf-8?B?Vlk3TytGc0pBaFVGVXJnbVFzRVFIMmdWdEVUc0VXbXlTTGZJVDdpQ0N0NFRI?=
 =?utf-8?B?ZVk5N216ajB5ZUttVURtbDRIcjJkcWxPRGp2SG14dUtrejQ5UmlxelZWRnlP?=
 =?utf-8?B?SmQ2TzdQczBJZVV6dk0zdEh5SDZSaTduMkdnWi94NXdUVmtRMWtTVmxVOW1Y?=
 =?utf-8?B?bXd2YnlBTmpuS1lNL0owYjE2cGRObytFRGpRQW9WRGtZSkJ2MExUL2g3NDd3?=
 =?utf-8?B?RXVYQlhGTHpIdE9XV0lwZ1V2cGNNb2VFVCtJR1Z2RVFiU1JleFkzdWdITnpR?=
 =?utf-8?B?M3lOT284SDdmVkx3S3JYS2hwTTdvU2JLTmFsWDRhQXg1TUcrV2lQSVo1eWU2?=
 =?utf-8?B?UTlIQ2tDNE5ubnJ1SlZQYlp5OStpL0N2ODFob1hDUXNnSXNxTlFqekJwSEJz?=
 =?utf-8?B?dnU1QmkwWFpEMUR3NW5BTkxlamNLSStGMHVGTFZTQjdRTUJ3UUxiRFdFbUVJ?=
 =?utf-8?B?cHZiOTBUNFVZd01aN0J0enV2WUNKWjhuTGFnODcrOTlWQWZtZ1R4anRjR3dY?=
 =?utf-8?B?S0pyY0xOZ0o0bWgxcGFqekZuV0k5bWRzQktzZzRQb3JQbGFOVEdVcVBHTEJV?=
 =?utf-8?B?cFQvN0pBYzBtUkdUMy80bVBhMFRnMExEN1dxaUVFMThsNktaSS9SQkFaT294?=
 =?utf-8?B?VExTUk5rQjg4TW1qWlBhVEN5Tkxja2pyL0Z2UVo1TWVuWUFKOU9WT2NnSzdQ?=
 =?utf-8?B?SDBNY2t2UVBMU2ZXWnBIOEF6cWJwUHRrR2pkSFM3Uk5TY3VxMlpCQWFYM2dH?=
 =?utf-8?B?SjhNSkV6aU50d2kybDJYTHlpYTRTdmNQV1V6Nkh2KzJEN0RUaXRobEtKYW8v?=
 =?utf-8?B?K2JzNCtndk9EU1lWc2tZSzQ1NDhBSGN5QlkzZmpZenl1ZS84UDZpTWhMVUs0?=
 =?utf-8?Q?Sq9r2MdjWjBli50zlMfBOjz6znLs7niWlfDNKyl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bcad78-58d4-4a54-aab3-08d91c9e0ab3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 21:18:56.0922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZzw2W7S+GSKzq4uc93fyDXpsx4sj5O2AD0XhEIZ26bXoOmd4o0FttOjiiWfbOwW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gUVVFUlkyIElPQ1RMIGRvbid0IHF1ZXJ5IGNvdW50cyBvZiBjb3JyZWN0YWJsZQphbmQgdW5j
b3JyZWN0YWJsZSBlcnJvcnMsIHNpbmNlIHdoZW4gUkFTIGlzCmVuYWJsZWQgYW5kIHN1cHBvcnRl
ZCBvbiBWZWdhMjAgc2VydmVyIGJvYXJkcywKdGhpcyB0YWtlcyBpbnN1cm1vdW50YWJseSBsb25n
IHRpbWUsIGluIE8obl4zKSwKd2hpY2ggc2xvd3MgdGhlIHN5c3RlbSBkb3duIHRvIHRoZSBwb2lu
dCBvZiBpdApiZWluZyB1bnVzYWJsZSB3aGVuIHdlIGhhdmUgR1VJIHVwLgoKRml4ZXM6IGFlMzYz
YTIxMmIxNCAoImRybS9hbWRncHU6IEFkZCBhIG5ldyBmbGFnIHRvIEFNREdQVV9DVFhfT1BfUVVF
UllfU1RBVEUyIikKQ2M6IEFsZXhhbmRlciBEZXVjaGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBMdWJlbiBUdWlr
b3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleGFuZGVyIERldWNoZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2N0eC5jIHwgMTYgLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwppbmRl
eCBmYzgzNDQ1ZmJjNDAuLmJiMGNmZTg3MWFiYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9jdHguYwpAQCAtMzM3LDcgKzMzNyw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2N0eF9x
dWVyeTIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiB7CiAJc3RydWN0IGFtZGdwdV9jdHgg
KmN0eDsKIAlzdHJ1Y3QgYW1kZ3B1X2N0eF9tZ3IgKm1ncjsKLQl1bnNpZ25lZCBsb25nIHJhc19j
b3VudGVyOwogCiAJaWYgKCFmcHJpdikKIAkJcmV0dXJuIC1FSU5WQUw7CkBAIC0zNjIsMjEgKzM2
MSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2N0eF9xdWVyeTIoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCiAJaWYgKGF0b21pY19yZWFkKCZjdHgtPmd1aWx0eSkpCiAJCW91dC0+c3RhdGUuZmxh
Z3MgfD0gQU1ER1BVX0NUWF9RVUVSWTJfRkxBR1NfR1VJTFRZOwogCi0JLypxdWVyeSB1ZSBjb3Vu
dCovCi0JcmFzX2NvdW50ZXIgPSBhbWRncHVfcmFzX3F1ZXJ5X2Vycm9yX2NvdW50KGFkZXYsIGZh
bHNlKTsKLQkvKnJhcyBjb3VudGVyIGlzIG1vbm90b25pYyBpbmNyZWFzaW5nKi8KLQlpZiAocmFz
X2NvdW50ZXIgIT0gY3R4LT5yYXNfY291bnRlcl91ZSkgewotCQlvdXQtPnN0YXRlLmZsYWdzIHw9
IEFNREdQVV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19VRTsKLQkJY3R4LT5yYXNfY291bnRlcl91ZSA9
IHJhc19jb3VudGVyOwotCX0KLQotCS8qcXVlcnkgY2UgY291bnQqLwotCXJhc19jb3VudGVyID0g
YW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9jb3VudChhZGV2LCB0cnVlKTsKLQlpZiAocmFzX2NvdW50
ZXIgIT0gY3R4LT5yYXNfY291bnRlcl9jZSkgewotCQlvdXQtPnN0YXRlLmZsYWdzIHw9IEFNREdQ
VV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19DRTsKLQkJY3R4LT5yYXNfY291bnRlcl9jZSA9IHJhc19j
b3VudGVyOwotCX0KLQogCW11dGV4X3VubG9jaygmbWdyLT5sb2NrKTsKIAlyZXR1cm4gMDsKIH0K
LS0gCjIuMzEuMS41MjcuZzJkNjc3ZTViMTUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
