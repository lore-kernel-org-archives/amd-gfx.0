Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CF2C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 08:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21D16525D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 08:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21D16525D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9149089DB8;
	Tue,  9 Mar 2021 08:47:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E51890BC
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 08:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPS222SddTFspb5R5oSt0jpcMKgqtmPcS4Ddt6kA55qOPdOEZxnZHXrHm1YmlinXj/3B/djL+LzXIsYS/7MwWuEkepvdfZHgFf7ozvjQ1GDc0yK3ko1PGNlLtjAgl44andkvjV7qDSwczAw8CWdxMJjiMjCYZ5BXOl5RuUMvcJCE/JGTDbd3aAl+a7vh0FpkqxjRu5HYBYLdJcmk3uuiqqa5kgW34MSpsJGOj9S60BtSHCZ3OFEmnqmvpe7RHvnOo+d41VIWr3anaP133WOwqenTpqcTDDvmtn6lH5zM29TglbhnGmVbB99Fh0Gxg6emU2tmFrQxt4sQkYfgIJGc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbyBl0faMCBm8sg3ImvSQipDAtEpL58yl2QHwe3d1p4=;
 b=cGB5S1W4dBbh+vAyxiGzgQ/oxByVvzcyVkTo6ZIIzFEwopIfb1fZgBzY/j2yzA1+qLfujaZRD0fXJEZNDGdd3NR5ItQyOe8FiL3nexm3ogaokfPkmmFiKZXrzV3MsOnhwSyXdXnN4sI2rpYX8rqA8LZRbut3NOW+rVqVz/rtMXqYST8x5UD/g/0KHjdZsCbLBAC2elj8MvAo2vX+lHwcVPwYJybQLf1tMGw6nPS14pK7ptW1TCgzG06dqVeE+3JB0rIyL0SAU0sUiDADSNN5HKJMz6kaSCWMKHAHrIDa7f2Lkv5AAr1wI82C3rZBHVvV88NrrPC+1TI1OLGyDbjQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbyBl0faMCBm8sg3ImvSQipDAtEpL58yl2QHwe3d1p4=;
 b=PTyynlkvIJxBJK8SJ+ORQSvmJM9PCLPGmazJE2/0hkz053wPfEI2Z6hCQLJTROyHSpRsxtLpxfRNaWNrccMUzRHfwqmXNISOE0b+vF/G4lat6rbM/+acz/kIE0qAbKKtQvumqThFmXuaSdZUhvF/cHIhIKoV4IuNISOTtuMicmU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1459.namprd12.prod.outlook.com (2603:10b6:405:e::8) by
 BN6PR12MB1377.namprd12.prod.outlook.com (2603:10b6:404:1c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Tue, 9 Mar 2021 08:47:13 +0000
Received: from BN6PR12MB1459.namprd12.prod.outlook.com
 ([fe80::21cc:170a:9889:4460]) by BN6PR12MB1459.namprd12.prod.outlook.com
 ([fe80::21cc:170a:9889:4460%3]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 08:47:13 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 3/5] drm/amdgpu: fb BO should be ttm_bo_type_device
Date: Tue,  9 Mar 2021 09:46:57 +0100
Message-Id: <20210309084659.37649-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309084659.37649-1-nirmoy.das@amd.com>
References: <20210309084659.37649-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.127.127]
X-ClientProxiedBy: AM9P193CA0028.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::33) To BN6PR12MB1459.namprd12.prod.outlook.com
 (2603:10b6:405:e::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.127.127) by
 AM9P193CA0028.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 08:47:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 623510fd-005c-4a10-6259-08d8e2d7ef25
X-MS-TrafficTypeDiagnostic: BN6PR12MB1377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB137714610AE1EA53F04275F08B929@BN6PR12MB1377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glK0Vt5PBCd0lZOrUjgdMJOHypRlNGN3UF/9U5X6+bZVYKEdKoxf6AOHAvsjXBYOl2BAYKr1OcVZJzfwVlF414fvLKcemXNieBMPqvc1RL7pvDJbGCV8qZK1fQGBvz/P85XDgHUS9BCk3rPWg6fJPx6eVjJ/aXULS4n2qZtEyxBmz/7cosSDIZqB1gDzST77oHfiSu5kbzzR/AmgvrcvUBIxePVKYZ/waXFM4LrWdnhni2uxJn85U6SJbup1eCeM3ZMMZNl7BI4AfJ06SYBBXIyzrvm5oA7wprQf85JHpaxcIaYnwQ33dOcJkTxfJgNuwDKi6sR+iXwG3I5UADnQedSnadBdTGnO2eCZ5jKHQR45OFvrgujvxFB9bExFsPDQX80U7wqBB+ENjXjQUCEt3jZgXHut2N0CueChQTPLPf8lLQOSjS5ae16sZq4xPQjsG4rMS3bnnDj/UvAu2oBnjHMPygAUYrmIYnNc8LtJLQYdZmPJtIKgJsvUYPDR46yaSP0Uf3jsl1D+mErQmHqWHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1459.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(66946007)(66574015)(6666004)(2906002)(83380400001)(316002)(4326008)(6506007)(36756003)(956004)(478600001)(8936002)(4744005)(5660300002)(44832011)(37006003)(1076003)(54906003)(52116002)(8676002)(6636002)(34206002)(66476007)(6486002)(66556008)(26005)(6512007)(186003)(86362001)(2616005)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VHpncE5ROTNpd0hvbjJIWHdOaXl3cnAwQzNqOTJDWWVmUEtEOU5jWmtYZnZK?=
 =?utf-8?B?QVZJS3FHUXd6OWVzZ0E0MmtTYW9xajFvbEk1QllQbDV2M21UR0RtNlhpQlBF?=
 =?utf-8?B?V01Ma1pSL1Y5WFBHOU8wT0FENTZQZFNhNUtIQnRwUkFscDVKWk5MQWFJRTMr?=
 =?utf-8?B?d29qbzhVVlhrR0g0TVNOVkp2eXpjWlQ3bHFTVmMxUmYranVaY1d4RmJqTG90?=
 =?utf-8?B?bERqUlJvcXMyVTFZTk5DWjBPN2w4TTl5N1loYlB2MGhPeFY2eW1iL3BjTXlo?=
 =?utf-8?B?MVF5K0xudGUyaTJaOUhLbkVSbmhnSWdNNTlRay95ZTdlQWdIL3FENytBY1U4?=
 =?utf-8?B?dzd6UWYxWjRlWHNsamVsOVVuajA3Qi9aV1hUbmlST3FGdXpJbCt2NytBSG0r?=
 =?utf-8?B?SEtLR3V5Z1NLeG1zbk54ZllhY29iWmc1QU4wOU1LSzVVeGJJVE91MVBqeitF?=
 =?utf-8?B?UDV1RTFGY0hjRUZ1ZDc5T1ZQb0dibm43Z3FTTGZvaU5qakEycW03MnowQjdr?=
 =?utf-8?B?b1VmTjV4TTcvOG9Cd1dwc2xQOXVod2NVL0ZVaEt0SzNpZXVVY1F6TVhMUC9L?=
 =?utf-8?B?RHFuM2k5MjQ1QTZQa05ZUmFQV1BKY3VYRUowSmJvUm1RZnQzUXpHUzlRMHRn?=
 =?utf-8?B?ZXZZUWVvaTNncjNKM1Rrb1IxQk1TRnlUVVIrUytPS3Q1ZnZqNzBHSlN6bUVi?=
 =?utf-8?B?NTM5L2oreEd2WUZ0cE5GdENzS0UrQ0NSZ1BRZ0NXaXp2a1I1YmpiVEU2aytT?=
 =?utf-8?B?K2xmNEVrTkZNUVRpTVZiemRBTTNFcWUrK1hOR1dwSTdxOFVHV2tvOVdyNjJv?=
 =?utf-8?B?cWszdWRkZGkxSlNBZWYzcTI3OVVyWlBNWWNyc05UOGsySjJBU242VW82aFJC?=
 =?utf-8?B?YzBhdktiVUJEVFZ0dTR6b3U4VnU2Q3hCZlR5Q2hHMWtqMmh2T0Z2UE9sVFhq?=
 =?utf-8?B?WitudG81Sm1abmRhT1E3RTZxSWF4akRtZjVmUUV1clRIS3ZSazFJY2lMMWdI?=
 =?utf-8?B?WHo5akNmWjJEVUFNV1FUS21LT1FZZjFzWldDMmtaMFYzeWVWaE9HVjRub0RM?=
 =?utf-8?B?Vzg1Z08rd1pNa3ZuWmIveno4Qzhta2ZZenkvOWh6MWxMOE1kNmtzZ1A2Vjl4?=
 =?utf-8?B?V1FXWC9BMFY5Q3R0WVl0alpadWNRZ3lTN2NHT1poSVB2MytJOE1zblRFUVNE?=
 =?utf-8?B?bWJuN084UkRJdU5VWXpJNFlnUk1BaDdOZG9KdGxaUStPbFJLdCs5RWp2VWh4?=
 =?utf-8?B?bTdtVlF1Q2Rscjk4cGVXR0ZKaEVacFJKOEpocFJ1cE84OUVPZWZ0UGExNCtE?=
 =?utf-8?B?UEJRd3RFbExOd053d2ZsU2FGTjYzbWZNOUFUWDcvY1ZjSFowZFhZaEhnWjRR?=
 =?utf-8?B?QmxYTk54V0ZnQi9FU0hGMnBhSFBjdSs1aDk5aTE5V0FDZm5yU3RFQm5uZSt1?=
 =?utf-8?B?eHYxMHpOVHI3blR4SmxpS0t5SjVmSFRWbjFRdmI1bmJBWHFtckUzVThWclhv?=
 =?utf-8?B?UmhGOER0c2VlQzc1R3JvQVZiQ0NpM3lVM1dPWDB5cWYwZm1JcW9Pc29ac1Qr?=
 =?utf-8?B?NTB0ajBjS2V6NlNESGprRDd0eXpZelppRCtGVGNyMTJmdmp3NnhCMzA0TE9E?=
 =?utf-8?B?SGxtUXFxL2JRNGozZk1nTkk2bWJFVzU5L0Q5UXVueVljdC9jdzBmcGZUbEtU?=
 =?utf-8?B?TVY2d0ZVcmJnczdQaGh6TGIwNEpaMGNrOEMxSE1raXVFWWVQU0xhWHVaSlFW?=
 =?utf-8?Q?sSq58hD+4ActzlcN1huySyGr3f+1l+Lxcm95bDp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623510fd-005c-4a10-6259-08d8e2d7ef25
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1459.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:47:13.3994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Pw7JWDY9ZlGRvZJzIlYg8utTDxe0r3s6dVy+ZpT7MsZFWuAm9VwoRE9NEg3dsaXxRgmgMF05VD7pmkqU2eMiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1377
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
Cc: Nirmoy Das <nirmoy.das@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RkIgQk8gc2hvdWxkIG5vdCBiZSB0dG1fYm9fdHlwZV9rZXJuZWwgdHlwZSBhbmQKYW1kZ3B1ZmJf
Y3JlYXRlX3Bpbm5lZF9vYmplY3QoKSBwaW5zIHRoZSBGQiBCTyBhbnl3YXkuCgpTaWduZWQtb2Zm
LWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+CkFja2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2ZiLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZmIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jCmlu
ZGV4IDUxY2Q0OWM2ZjM4Zi4uMjQwMTBjYWNmN2QwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZmIuYwpAQCAtMTQ2LDcgKzE0Niw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1ZmJfY3Jl
YXRlX3Bpbm5lZF9vYmplY3Qoc3RydWN0IGFtZGdwdV9mYmRldiAqcmZiZGV2LAogCXNpemUgPSBt
b2RlX2NtZC0+cGl0Y2hlc1swXSAqIGhlaWdodDsKIAlhbGlnbmVkX3NpemUgPSBBTElHTihzaXpl
LCBQQUdFX1NJWkUpOwogCXJldCA9IGFtZGdwdV9nZW1fb2JqZWN0X2NyZWF0ZShhZGV2LCBhbGln
bmVkX3NpemUsIDAsIGRvbWFpbiwgZmxhZ3MsCi0JCQkJICAgICAgIHR0bV9ib190eXBlX2tlcm5l
bCwgTlVMTCwgJmdvYmopOworCQkJCSAgICAgICB0dG1fYm9fdHlwZV9kZXZpY2UsIE5VTEwsICZn
b2JqKTsKIAlpZiAocmV0KSB7CiAJCXByX2VycigiZmFpbGVkIHRvIGFsbG9jYXRlIGZyYW1lYnVm
ZmVyICglZClcbiIsIGFsaWduZWRfc2l6ZSk7CiAJCXJldHVybiAtRU5PTUVNOwotLSAKMi4zMC4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
