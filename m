Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44738C4707F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 00:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0888D6023C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 00:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0888D6023C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F346EB95;
	Wed, 26 May 2021 00:41:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBAED6E454
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 00:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWbP+B924G1b4CSTrQ3UWaRNudShUzaY4QJy+kn9aC5RpaK8oGJDjBjCxA6GGi3vJZEgw0zxiZ9ry40DnQ2Nzt0WxHYMB5ifO9E7iHsKGK/n4QC8HgHHJt9RAqdPWekQW5ci9c8ZEifqKmEHsEhlBLUdat2/U3OvZK9UpV2DfnGeWdjip71DaP12dcPqx2quHQYxW/4BzpurFkWcufl5YsJmcFU2HFW00kEcUQ0I6DZRhl7w7JkwVo0ORfgDGkQGbNCSru3P0wI9ie3aiajjXkaKcxgsQselJCBql5BoYm5C4GG6yJn/wNlNStHzRMHYRuTwwr88Z86UbcB30aVA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2340/84+BNxcHzRXy9B6OqOoypDW92pC7htUAEnRis=;
 b=H0+NUTWs553KSRBdsR7P9gxwLcgjJQkAPyWNt53V21q7QgrkSWCkqnT1C+crTNBqc+w4xvta8mEQZClA7zkGjYc0aht0I70a6N7YyjG+WFR+HstxP6pooWI8CId6smn/EWU04Yg+p/9OvYRarxrIw/Ys8NRGs1on3+yrM50Ezjp58kKCW9euigUlMKY/+PEBJZpI8Oku3xa5pg/JnIrSis0w4uEeNFHqmSe8YlsoyaYXQgB4wwi6cHgP8Pt3q2DNOK+2MWL2jouCA/sZGm/YQICvdM0CVzLFbrqOE3QwJZpPYz2TO1aqIBfeN3Gl1BwhWReErBOYyGlK2RNTPt1rzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2340/84+BNxcHzRXy9B6OqOoypDW92pC7htUAEnRis=;
 b=zBHWi8YI+gH4CXArmtiHsUso6WZlnRjDN/0OL4Ou9TG4sT37DKLiPyPPNg3gbDXJjWuGAYEe2k8FHMuaTwe8moMuMIAP3l9pYAySROM55GAGRs4Pe+hIO97Sg6C7TnkM9ElcWuCRonnE8XHlrJNhHv3qVOHrdfOSw3nsGD+Dduk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1641.namprd12.prod.outlook.com (2603:10b6:4:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 00:41:04 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 00:41:04 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error counters
Date: Tue, 25 May 2021 20:40:44 -0400
Message-Id: <20210526004044.58986-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
In-Reply-To: <20210526004044.58986-1-luben.tuikov@amd.com>
References: <20210526004044.58986-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::43) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Wed, 26 May 2021 00:41:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c67e9c2-ff80-4600-6042-08d91fdef126
X-MS-TrafficTypeDiagnostic: DM5PR12MB1641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB16414D9C22F14D8AF6F76EB599249@DM5PR12MB1641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fg1e4Dl9Uth2tdMilIQSW1TtE5vexg+6gHC/KcHxBX4Jq1BL2gAVB25hzdLJLPhEHgqDozEbKLXOz8DTU1zSw6FxOWdUAQheL1mPw3K6erAg2rvbOZyn1Xd2Ki93WFEahZk8aaz/eusk+ZPMfnEnjxtl7UHJ1g4YJXHc/f29f96EdBEYLv50nLG/U9tkbx0ey7MKQUDpAKIi4HulMGcD6XkP75+C0SrNJPXYqjmPe/HGy6V9evPaMzVFkwQnH6OW2vADOYdshk6J2zcmhTw7yrkThcKb9rJQ0BKL1WBecYK+4NJqTxeD+sKzcBn5NHZagwnd5CDq7PHfjKpQEEWxz6bim1I/6b8L5/kTBFCfeWW5f5s2DZ/BzuTquW2jlidoGsJnEAk/UItAZFtSLGSOqoSgc9vlTOiOqGWv6FbnYNb25+f2m/D4LhDRgFKU3Bp0e/x3uk0WEJ6hIRGgg+o2NzCmEXv38XAPY3A3L+8H68dhjlYeeTJB8AER3RL4AZSf8siIjCJ3LRm0wDuX8XVKKIxE2g98V6SQDzURPLSZ1hDg1BhKkxkngya+9tRK5LsLQaua6Hn7IlO6usACuYNGzLvSMAEaNO2Wm9bk4JJY34Tsnu9DSmkhi0V31WaFn8an9UZmoi78N8BQ4oZil0Libg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(52116002)(26005)(55236004)(186003)(16526019)(66476007)(2616005)(478600001)(6506007)(66556008)(86362001)(83380400001)(2906002)(38350700002)(66946007)(6916009)(36756003)(316002)(8936002)(38100700002)(4326008)(6512007)(5660300002)(956004)(8676002)(44832011)(6486002)(66574015)(54906003)(6666004)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cDFzM1gyaG8rSDRiaVhQMnlaSkVHaFowT2g5N1E5TnZienZDRmNya3RmRjMz?=
 =?utf-8?B?VHlnK2ZDeldQbHdIcnUrUysxK1NzWXp1RCtGaUJMcTAzc0F4VzR1YXVLOEFt?=
 =?utf-8?B?UDE5R2VjL0FYWDNCaUhTMzBFZzV6ME1YaFJFV1Q5bkxtLzRocmZRa0RzRjJ4?=
 =?utf-8?B?VXF3TXAxek5hTTExZDZQcmVLY0QxS1RpTTltdUk0S3d1UDhPUlpWUHdWd201?=
 =?utf-8?B?Q01hQUJrdnZmM1dSckJBRm5PcFByK1VSK1pRQ3hxUmd2c01qQ0lobG9PakdL?=
 =?utf-8?B?dGJNRDdjMXRZZEtETlk2aGtmWXNKci9sV2FXdGFsZjUwNllLSEZCOG1MV1M1?=
 =?utf-8?B?dlFYaC9raEd2WmlJbWlvMnZ0aGNKTmEwdkFHQ1VDakZBbTRhdjdwZFQ2cllo?=
 =?utf-8?B?NUNRZXEzbXhkYXMrSUMrOVZ2WjNPNm9kazdIMkUzM094bmkwYW1ZYm5rQUVn?=
 =?utf-8?B?UEQ0YnJMeHMvQVI2Wm1vc0VReW52SEJtRGVKcThoZnlDNjFPM0svVVRxS2l4?=
 =?utf-8?B?bVNEb2Y1ZkE4bW9tYzJCV1kwRVJnanJZSVJNTG5VS3Z2RTZmQy9NbmhuRmlB?=
 =?utf-8?B?dnJPV0VmZzVCQlFTZWNvak9ZTndINWN0WGE5WWk0QlNqWWpucCs1TXd5ZUl5?=
 =?utf-8?B?R1pjYzVWd2hDUi8rNzJCSk9FTDdmYW9WeFdVMDQ3L3NPd01PcElpc2kyWDVv?=
 =?utf-8?B?cERRcXJONmNJcnMvVjBDamtXZXhFeUpZMmdhTGh6QTU5NnpERS9aYVlRRmZk?=
 =?utf-8?B?REw1dVhVd0gxSlhodnRqWlVPY3B4VTdseDJHL2EvUHQ5MmUrMzFUdlZJa3lX?=
 =?utf-8?B?UUlFem9xVnU3Zjhab2RaZmM2cjhjV3NGV2lsM1lTeXp1OHRFaVdVNElyU0NR?=
 =?utf-8?B?Rzc1amc3RjN1NFBQYlBVM2pGQUt3ZlltVEJpSTZETHBva2U0cFRhWGZJMjhV?=
 =?utf-8?B?WmVQTy9MUmlXS0JONmxBU2lSQnNKMWZZaFRKWlBtYmJtdzRpQjJBM1RtUEpu?=
 =?utf-8?B?OUROU0tyS0tTemNteDBFUUJQNFBzOUtzcWRYYW5nSDlKM0d2RHg0NmI2Q3hm?=
 =?utf-8?B?cEhhZmR1VjJOL1F1aFd3bVoxWWFTbnlwWDlKNUlkSnNGNFc0aUUrTHBrem9o?=
 =?utf-8?B?Q0JTNGxnR2d4c2svYW04OEJtUWJJSHJyQS9odUZPM0ZGeVNEc3BEdDhkNXVM?=
 =?utf-8?B?RGZOejhTU1dzWTlZZWlLbEZKZ0ZuaEZES3VRN2licnJQVVBuekNuWldrWFR1?=
 =?utf-8?B?SHZzV044eFVDN0ZnYVQyWmk0Slp6RFl0aHNHTHh5MDkvNFdUYTNlT1JFY1M0?=
 =?utf-8?B?blN5TVVWYnpYbjcyMkY1cEl1dnBMVkFFcnRONVhySHVkTG1aNkJSMk03YXpG?=
 =?utf-8?B?dHB4VkRQQ0lxQzBmUGFZQWs3cWpmdGlEZWpUbXpyRUZIeWNsU2dKQ09aR0Vj?=
 =?utf-8?B?Si9BelI0WElibEdzSy9nNWFqdXhOcUxTd1MxbHgzYkpMZjJJM09tN1JETFZJ?=
 =?utf-8?B?SVVybVZ2bjA0OTNhMVRleFV1Z2NmTW1pZkNpbG9zM1ZrelJiVDh4UEQzWTM5?=
 =?utf-8?B?RitBY0ZaYWRyb2kzL3M5MEExT3dxNTg0cXpaY1FPY0ZwckRaRHAxSzF5QWNx?=
 =?utf-8?B?MWFYQjBRcERzWVlmZFBjdVJxeXYzUW5CT1Q5MjFtYWgyMVJFQkRTVXB5Y3Vm?=
 =?utf-8?B?N2h4QVBMTmgzQUs5Q291QXRyb3ViMSthZmlkVGM5WjNNSEZCdVdUM1l6MmVU?=
 =?utf-8?Q?7X1SNRRa+tpsxPs/fSITf3NErp5PPS6rV8MSk20?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c67e9c2-ff80-4600-6042-08d91fdef126
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 00:41:03.9999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kknjZbNoxZMv3fkOJAjiEGA171vZevAMK5UgT0aoy8IFW2JxDnhJpCWUWw5fNNbw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1641
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
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gQ29udGV4dCBRdWVyeTIgSU9DVEwgcmV0dXJuIHRoZSBjb3JyZWN0YWJsZSBhbmQKdW5jb3Jy
ZWN0YWJsZSBlcnJvcnMgaW4gTygxKSBmYXNoaW9uLCBmcm9tIGNhY2hlZAp2YWx1ZXMsIGFuZCBz
Y2hlZHVsZSBhIGRlbGF5ZWQgd29yayBmdW5jdGlvbiB0bwpjYWxjdWxhdGUgYW5kIGNhY2hlIHRo
ZW0gZm9yIHRoZSBuZXh0IHN1Y2ggSU9DVEwuCgp2MjogQ2FuY2VsIHBlbmRpbmcgZGVsYXllZCB3
b3JrIGF0IHJhc19maW5pKCkuCgpDYzogQWxleGFuZGVyIERldWNoZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+CkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+CkNjOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNjOiBIYXdraW5n
IFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEx1YmVuIFR1aWtv
diA8bHViZW4udHVpa292QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2N0eC5jIHwgMzIgKysrKysrKysrKysrKysrKystLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKwogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oIHwgIDUgKysrCiAzIGZpbGVzIGNo
YW5nZWQsIDc2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2N0eC5jCmluZGV4IGJiMGNmZTg3MWFiYS4uNGU5NWQyNTU5NjBiIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCkBAIC0zMzEsMTAgKzMzMSwx
MyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jdHhfcXVlcnkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCiAJcmV0dXJuIDA7CiB9CiAKKyNkZWZpbmUgQU1ER1BVX1JBU19DT1VOVEVfREVMQVlfTVMg
MzAwMAorCiBzdGF0aWMgaW50IGFtZGdwdV9jdHhfcXVlcnkyKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAotCXN0cnVjdCBhbWRncHVfZnByaXYgKmZwcml2LCB1aW50MzJfdCBpZCwKLQl1bmlv
biBkcm1fYW1kZ3B1X2N0eF9vdXQgKm91dCkKKwkJCSAgICAgc3RydWN0IGFtZGdwdV9mcHJpdiAq
ZnByaXYsIHVpbnQzMl90IGlkLAorCQkJICAgICB1bmlvbiBkcm1fYW1kZ3B1X2N0eF9vdXQgKm91
dCkKIHsKKwlzdHJ1Y3QgYW1kZ3B1X3JhcyAqY29uID0gYW1kZ3B1X3Jhc19nZXRfY29udGV4dChh
ZGV2KTsKIAlzdHJ1Y3QgYW1kZ3B1X2N0eCAqY3R4OwogCXN0cnVjdCBhbWRncHVfY3R4X21nciAq
bWdyOwogCkBAIC0zNjEsNiArMzY0LDMxIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2N0eF9xdWVyeTIo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJaWYgKGF0b21pY19yZWFkKCZjdHgtPmd1aWx0
eSkpCiAJCW91dC0+c3RhdGUuZmxhZ3MgfD0gQU1ER1BVX0NUWF9RVUVSWTJfRkxBR1NfR1VJTFRZ
OwogCisJaWYgKGFkZXYtPnJhc19lbmFibGVkICYmIGNvbikgeworCQkvKiBSZXR1cm4gdGhlIGNh
Y2hlZCB2YWx1ZXMgaW4gTygxKSwKKwkJICogYW5kIHNjaGVkdWxlIGRlbGF5ZWQgd29yayB0byBj
YWNoZQorCQkgKiBuZXcgdmF1ZXMuCisJCSAqLworCQlpbnQgY2VfY291bnQsIHVlX2NvdW50Owor
CisJCWNlX2NvdW50ID0gYXRvbWljX3JlYWQoJmNvbi0+cmFzX2NlX2NvdW50KTsKKwkJdWVfY291
bnQgPSBhdG9taWNfcmVhZCgmY29uLT5yYXNfdWVfY291bnQpOworCisJCWlmIChjZV9jb3VudCAh
PSBjdHgtPnJhc19jb3VudGVyX2NlKSB7CisJCQljdHgtPnJhc19jb3VudGVyX2NlID0gY2VfY291
bnQ7CisJCQlvdXQtPnN0YXRlLmZsYWdzIHw9IEFNREdQVV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19D
RTsKKwkJfQorCisJCWlmICh1ZV9jb3VudCAhPSBjdHgtPnJhc19jb3VudGVyX3VlKSB7CisJCQlj
dHgtPnJhc19jb3VudGVyX3VlID0gdWVfY291bnQ7CisJCQlvdXQtPnN0YXRlLmZsYWdzIHw9IEFN
REdQVV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19VRTsKKwkJfQorCisJCWlmICghZGVsYXllZF93b3Jr
X3BlbmRpbmcoJmNvbi0+cmFzX2NvdW50ZV9kZWxheV93b3JrKSkKKwkJCXNjaGVkdWxlX2RlbGF5
ZWRfd29yaygmY29uLT5yYXNfY291bnRlX2RlbGF5X3dvcmssCisJCQkJICBtc2Vjc190b19qaWZm
aWVzKEFNREdQVV9SQVNfQ09VTlRFX0RFTEFZX01TKSk7CisJfQorCiAJbXV0ZXhfdW5sb2NrKCZt
Z3ItPmxvY2spOwogCXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5jCmluZGV4IGVkM2M0M2U4YjBiNS4uMDExMTQ1MjkwNDBhIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCkBAIC0yNyw2ICsyNyw3IEBACiAjaW5jbHVkZSA8bGlu
dXgvdWFjY2Vzcy5oPgogI2luY2x1ZGUgPGxpbnV4L3JlYm9vdC5oPgogI2luY2x1ZGUgPGxpbnV4
L3N5c2NhbGxzLmg+CisjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPgogCiAjaW5jbHVkZSAi
YW1kZ3B1LmgiCiAjaW5jbHVkZSAiYW1kZ3B1X3Jhcy5oIgpAQCAtMjExNiw2ICsyMTE3LDMwIEBA
IHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfY2hlY2tfc3VwcG9ydGVkKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQogCQlhZGV2LT5yYXNfaHdfZW5hYmxlZCAmIGFtZGdwdV9yYXNfbWFzazsKIH0K
IAorc3RhdGljIHZvaWQgYW1kZ3B1X3Jhc19jb3VudGVfZHcoc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKQoreworCXN0cnVjdCBhbWRncHVfcmFzICpjb24gPSBjb250YWluZXJfb2Yod29yaywgc3Ry
dWN0IGFtZGdwdV9yYXMsCisJCQkJCSAgICAgIHJhc19jb3VudGVfZGVsYXlfd29yay53b3JrKTsK
KwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGNvbi0+YWRldjsKKwlzdHJ1Y3QgZHJtX2Rl
dmljZSAqZGV2ID0gJmFkZXYtPmRkZXY7CisJdW5zaWduZWQgbG9uZyBjZV9jb3VudCwgdWVfY291
bnQ7CisJaW50IHJlczsKKworCXJlcyA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2LT5kZXYpOwor
CWlmIChyZXMgPCAwKQorCQlnb3RvIE91dDsKKworCS8qIENhY2hlIG5ldyB2YWx1ZXMuCisJICov
CisJYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9jb3VudChhZGV2LCAmY2VfY291bnQsICZ1ZV9jb3Vu
dCk7CisJYXRvbWljX3NldCgmY29uLT5yYXNfY2VfY291bnQsIGNlX2NvdW50KTsKKwlhdG9taWNf
c2V0KCZjb24tPnJhc191ZV9jb3VudCwgdWVfY291bnQpOworCisJcG1fcnVudGltZV9tYXJrX2xh
c3RfYnVzeShkZXYtPmRldik7CitPdXQ6CisJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoZGV2
LT5kZXYpOworfQorCiBpbnQgYW1kZ3B1X3Jhc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogewogCXN0cnVjdCBhbWRncHVfcmFzICpjb24gPSBhbWRncHVfcmFzX2dldF9jb250ZXh0
KGFkZXYpOwpAQCAtMjEzMCw2ICsyMTU1LDExIEBAIGludCBhbWRncHVfcmFzX2luaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJaWYgKCFjb24pCiAJCXJldHVybiAtRU5PTUVNOwogCisJ
Y29uLT5hZGV2ID0gYWRldjsKKwlJTklUX0RFTEFZRURfV09SSygmY29uLT5yYXNfY291bnRlX2Rl
bGF5X3dvcmssIGFtZGdwdV9yYXNfY291bnRlX2R3KTsKKwlhdG9taWNfc2V0KCZjb24tPnJhc19j
ZV9jb3VudCwgMCk7CisJYXRvbWljX3NldCgmY29uLT5yYXNfdWVfY291bnQsIDApOworCiAJY29u
LT5vYmpzID0gKHN0cnVjdCByYXNfbWFuYWdlciAqKShjb24gKyAxKTsKIAogCWFtZGdwdV9yYXNf
c2V0X2NvbnRleHQoYWRldiwgY29uKTsKQEAgLTIyMzMsNiArMjI2Myw4IEBAIGludCBhbWRncHVf
cmFzX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSBzdHJ1Y3QgcmFz
X2ZzX2lmICpmc19pbmZvLAogCQkJIHN0cnVjdCByYXNfaWhfaWYgKmloX2luZm8pCiB7CisJc3Ry
dWN0IGFtZGdwdV9yYXMgKmNvbiA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRleHQoYWRldik7CisJdW5z
aWduZWQgbG9uZyB1ZV9jb3VudCwgY2VfY291bnQ7CiAJaW50IHI7CiAKIAkvKiBkaXNhYmxlIFJB
UyBmZWF0dXJlIHBlciBJUCBibG9jayBpZiBpdCBpcyBub3Qgc3VwcG9ydGVkICovCkBAIC0yMjcz
LDYgKzIzMDUsMTIgQEAgaW50IGFtZGdwdV9yYXNfbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAogCWlmIChyKQogCQlnb3RvIHN5c2ZzOwogCisJLyogVGhvc2UgYXJlIHRoZSBj
YWNoZWQgdmFsdWVzIGF0IGluaXQuCisJICovCisJYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9jb3Vu
dChhZGV2LCAmY2VfY291bnQsICZ1ZV9jb3VudCk7CisJYXRvbWljX3NldCgmY29uLT5yYXNfY2Vf
Y291bnQsIGNlX2NvdW50KTsKKwlhdG9taWNfc2V0KCZjb24tPnJhc191ZV9jb3VudCwgdWVfY291
bnQpOworCiAJcmV0dXJuIDA7CiBjbGVhbnVwOgogCWFtZGdwdV9yYXNfc3lzZnNfcmVtb3ZlKGFk
ZXYsIHJhc19ibG9jayk7CkBAIC0yMzkwLDYgKzI0MjgsOSBAQCBpbnQgYW1kZ3B1X3Jhc19maW5p
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWlmIChjb24tPmZlYXR1cmVzKQogCQlhbWRn
cHVfcmFzX2Rpc2FibGVfYWxsX2ZlYXR1cmVzKGFkZXYsIDEpOwogCisJaWYgKGRlbGF5ZWRfd29y
a19wZW5kaW5nKCZjb24tPnJhc19jb3VudGVfZGVsYXlfd29yaykpCisJCWNhbmNlbF9kZWxheWVk
X3dvcmtfc3luYygmY29uLT5yYXNfY291bnRlX2RlbGF5X3dvcmspOworCiAJYW1kZ3B1X3Jhc19z
ZXRfY29udGV4dChhZGV2LCBOVUxMKTsKIAlrZnJlZShjb24pOwogCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmgKaW5kZXggMTBmY2EwMzkzMTA2Li4yNTZjZWE1ZDM0ZjIgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaAorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgKQEAgLTM0MCw2ICszNDAsMTEg
QEAgc3RydWN0IGFtZGdwdV9yYXMgewogCiAJLyogZGlzYWJsZSByYXMgZXJyb3IgY291bnQgaGFy
dmVzdCBpbiByZWNvdmVyeSAqLwogCWJvb2wgZGlzYWJsZV9yYXNfZXJyX2NudF9oYXJ2ZXN0Owor
CisJLyogUkFTIGNvdW50IGVycm9ycyBkZWxheWVkIHdvcmsgKi8KKwlzdHJ1Y3QgZGVsYXllZF93
b3JrIHJhc19jb3VudGVfZGVsYXlfd29yazsKKwlhdG9taWNfdCByYXNfdWVfY291bnQ7CisJYXRv
bWljX3QgcmFzX2NlX2NvdW50OwogfTsKIAogc3RydWN0IHJhc19mc19kYXRhIHsKLS0gCjIuMzEu
MS41MjcuZzJkNjc3ZTViMTUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
