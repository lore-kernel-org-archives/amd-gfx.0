Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DABC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A3A61006
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A3A61006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F656EC66;
	Tue, 18 May 2021 18:13:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B255C6EC65;
 Tue, 18 May 2021 18:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9RvvZj5kXnEis37JAsyYhnXO3f6DeWRu2mAsHPtojFlrl52xubKyO2w6YmYjz1PmqAxBBdvFKlDK1oqZ6mLPskfZQJ2nWyziOdECFBTpw12JWLU0jjKDo6vXsIk36WI6AR9upLaE327H7RrieOuc63VVrsRn8hGXZxXvpvFQdQThb1fcV28oY7OBVlTSo0sj0/2vWeR5Bj3SFw8+bbTzFg44roIZ/cZu/kHlZRW0BOT3dt03BGDj3j4eQqAc0U+4X9aVMidsr32+3MAucVgtsWK8ZOUXGobDyNi8nHy/lLnw2QUUHEMdWnRhLp3mLtWPpqLgZuyMnjHZ4eCPmZb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFlrJ7AZKW+/px8ID9mqaFFw7cIfXeN4e7GWwWCjGTo=;
 b=YBBII7hhW81H2EAxkwLV/G42k4zkvsYmuVqUHeawaHDAjogpJrY1KcQxQEH1X8RDHaTwlOsTBR2gNHoxToCtxy269PmtStYtKl0pvxsYviAwo3tZVARKwresfYjlNKFlLk3Gx5su4q4p8CQ0XgibDxAhnBlNj3Jtb8xzUHyfQUcF41EdivJGkBXebZ13ewgcKBfqAULb6qtih0ivqBriw+QJ+Zz67UyyZBT7jVHfcZH72Q6uhv8CNo4V9IFrLfUcocwYeH8DshAzAh3w7uzKuEXG++1Fkn+rIhkS9tYUQkN3owyEaaenVFSn/H8r1es27KEHwWPaX5imgrVOtY1zBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFlrJ7AZKW+/px8ID9mqaFFw7cIfXeN4e7GWwWCjGTo=;
 b=lrr/CTOSEhXpK4sS2DyMDL1cHjyFuwmnKB/OIr+ebWGzEUQu4vEsRFmngofWghswj1Abo6E5QDGlzoxj3isbLePLWsxAZsfDuBK1lWZ4fGLgadPwIP+G6kwUkTzK6H9WA8yG7eDlzg1nv3DlNCoQq/wOLNRWiy5aIGgoS4tGvD4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2450.namprd12.prod.outlook.com (2603:10b6:207:4d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 18:13:48 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 18:13:48 +0000
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
 <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
 <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
 <34d4e4a8-c577-dfe6-3190-28a5c63a2d23@amd.com>
 <da1f9706-d918-cff8-2807-25da0c01fcde@amd.com>
 <8228ea6b-4faf-bb7e-aaf4-8949932e869a@amd.com>
 <ec157a35-85fb-11e5-226a-c25d699102c6@amd.com>
 <53f281cc-e4c0-ea5d-9415-4413c85a6a16@amd.com>
 <0b49fc7b-ca0b-58c4-3f76-c4a5fab97bdc@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <31febf08-e9c9-77fa-932d-a50505866ec4@amd.com>
Date: Tue, 18 May 2021 20:13:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <0b49fc7b-ca0b-58c4-3f76-c4a5fab97bdc@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:88c7:d7d9:22ef:f850]
X-ClientProxiedBy: PR0P264CA0232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:88c7:d7d9:22ef:f850]
 (2a02:908:1252:fb60:88c7:d7d9:22ef:f850) by
 PR0P264CA0232.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 18:13:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 324f9861-13db-4bc6-fcef-08d91a28ae93
X-MS-TrafficTypeDiagnostic: BL0PR12MB2450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2450210727C0FA2AF3DEC94E832C9@BL0PR12MB2450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBg7p48ZCcyz3k5jpgN2aaeXoZOj9UA5oDBw/Q4uaNrijEaON4xYd9MqXSlY7g8z8vfUZLlpBw7xy0jXwGDZ6nx+T2fDHGXSBMHwTSWBJFur3PaFeNYAKZ0HQ1DHd9BzvLU4Cprd+SJnb7RhtEpiEDMKP3X1TgM+/EP9iDa+ffNHNSATE68XfEfPo+05pLrn4OXKytd8bI3AZuNOeWNuZbG5xOBrueS6plMPRZBqc2gfvIcAIwNMiQU5kAdeAEIHHdlkPTlVrhYSbH2XckpZwCnWy315dgSDQ3kZPKxo6IR1x3VE9mMvJNfj3RsAGMbLUs2TlFkcsbeGkzK0JPojfQpw9gD3lrkbu5zZakcYX4ViM5Ya1/kZyJQQc3n7gt0rXbocjUAGKmCr4KdQrsN4QsOPG/W4bkPrZlZH9UQcS03maEK+jkPCTgrbetaMzxPCCzhopjL0y4SAPkTt/7wH0rCe0fOeqtM3d8T4BsL2ZwA8JGqydYZyvmhOylOE2qfmfEEgN34663jWg+YReDjaU638oedILyW7v/PUeCoie29r864/lL6/qUMKqlhc5tgY3YoK5s/YlaFThu9VOFIA5obj8qOUdiwak786iMlM332Grb79zD7P505K4qB3r2zIvAWiIKi1ahMUB3KzQYlIWHiHz9q58F30QMNnhSKRY9ggu2LNlny4ZvZiNNVvl0qH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(38100700002)(66574015)(31696002)(6636002)(83380400001)(53546011)(186003)(4326008)(8676002)(6666004)(86362001)(66946007)(31686004)(316002)(52116002)(2616005)(6486002)(8936002)(16526019)(5660300002)(66556008)(36756003)(66476007)(478600001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UkR2T3FDYzZMVkV0SWpyU21oOEZOYVQ2cDZMd2xKbHB1RVpNY3d6aERlYnEz?=
 =?utf-8?B?Y2VnaXFxTjJZY1Y3NzZlcGlmS2p0ak9pK2MxTk9IK0lXNzRUcTVxc2l5d2FE?=
 =?utf-8?B?c3NtaVd6empkYXMxWnFvNWJuQTVwTEtPak9DR1dZT2hUMTZ3dHowZjlNejNr?=
 =?utf-8?B?czlVdVZpcERzT3V6bUxObE1DTUQwdEN0UGlnbk90ZUQvT1BGOUxEQ1Y4Q2xG?=
 =?utf-8?B?MDV6V052UDllQVpmZi8wZWlHTG5pMUw4eTQyRGFCNkFIcEZuNUNzczN6cEs0?=
 =?utf-8?B?VVdBeGphOG5NSjdlRis0dVFsUE92OFVycUFGNU9tY0ZsY2Q3VmhWUXhkNmx1?=
 =?utf-8?B?cjFSb2ViN0w4RWo5M0xpbWR6SmduVGJZbmdGNjlUN0NDb2k5TmNQNXRFM1FV?=
 =?utf-8?B?Q3R5SVpsMWV2NEd1bVM5REdVUDJjQi9XbkZCS0JFam04WmQrRjJGLzc5RUNU?=
 =?utf-8?B?VnhCVVoybldsMDJ4aktXeTczc1VTeFdUTXN3Tm52RlFRenZ1cWxSN3NiS2RG?=
 =?utf-8?B?MzV2bWNjR1Q3UlI5VlhGRW9tK1hzNUkxZEJBNUF1bUJHT2U5T0pMZCtURGQv?=
 =?utf-8?B?QWVWUHZWb2YxSGRlT3dOeUR6MmxyVks0ZXZZMUc4anMzNHkzdlVKZDJOUnkv?=
 =?utf-8?B?YytFTDBWNTZWRk5jZ1NDM3B3RDFrWjYrYnFhbWwxell2MGV1bmZ6ckF1blhu?=
 =?utf-8?B?SUwrVy9FOThzQUlKWFJ5QkFOMVdBbVhIY3BVMnJzL21HVUUvQ2hNdWRMQ2to?=
 =?utf-8?B?aS8zTU5yczRJZFpoaUY1ZlduZlVGSFB2Y2xucWpJYVNvUDNMeFlvc1ZYZnB1?=
 =?utf-8?B?TDFCUHJ5RWh4M29Od1VqVFdsZUVnOGEzalVaK01oRis5WTY3NkU3aWFKbCtp?=
 =?utf-8?B?UUxzYmM3OVBHM3hydTNER1JBSmoyc080TEdJNlU1SkhDTGRPVWdCekdHazFV?=
 =?utf-8?B?enZHTkZra293dEJrVDlwdXZkLzVvM25neGlEWW1nUlJDTmNrdWo2VU9QaE13?=
 =?utf-8?B?bnVZbllqS1pqK204UlJSL0xHMnRSbW4vNHNkNVBWdDFkTDdiS2Q3a1Z5RS9y?=
 =?utf-8?B?Tnk4NndsMFBHYlFDek9HZkF3UFJTQzFkN0FBTitNU1IzY1VreHltc2RaanJt?=
 =?utf-8?B?R0IyNWx2QndPUFh3UitlaTlpZDVnRXdQMU1Oc2tTeHc3YVBrQTNaQ0krU1ly?=
 =?utf-8?B?THZXaXpMUHdDMnFhS1M3T2k5N3dCM0E4SGhYQ1cybUJXcytWa2NVMVlHZzd2?=
 =?utf-8?B?M1k4UGZQV1pHdzBjYTMvVDdiSXNOSVUwaVJ4Zi9vS21nWlBlSHFSelJ1Qzhu?=
 =?utf-8?B?NkxqNUlIcVRTclhhcmhsUjg4QTJBVWtEVXFkY2lhb3dFbE10akMrQjhRS3hV?=
 =?utf-8?B?NEZFenlZZ3dIZGZQb0tiazdZbUZvMUxBTThpV3lieUhTamZvaURKSHNFakZM?=
 =?utf-8?B?TkZ3aGZKeEFCTEZWSVRaMERydDhqNm5YZm5TQy9EMVUyZVA0ekJCMFl1amdu?=
 =?utf-8?B?Rko4UUxvK0hMM205RG5CUUNqWHdRK05aRjJGYzBhYmVMNzQ5TjFrbEtaaWZY?=
 =?utf-8?B?U3JRVTFpNmlmeXVqY0FNaE95YVNHUElBNVExYVlDbnNUWFIzdDV6dmJMVWht?=
 =?utf-8?B?S1lYMzRjVVpTcUF3MHZ1OXpUY2huUkZ6SExnZGJlTmxhMmtNekh3MytTYXpk?=
 =?utf-8?B?U2FhN1R6RlFTRklsNW8ySnBSQW9YM0J6YmJER0NpRUQvaURBcjEwZkt2SEpt?=
 =?utf-8?B?TjNDd3BwL1VNamxQQWx5ZXZaczN0dzBmL1JvcC8zUzdETEF3YitqVVVpc2Na?=
 =?utf-8?B?OHV1UXg4WVFJbHlMRFBnYU8zNWxHK0w3cXcxU05ycmRoVE9SbVFvVkk1Q2pi?=
 =?utf-8?Q?PT95X84u2dezz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324f9861-13db-4bc6-fcef-08d91a28ae93
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 18:13:48.1352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAdEpfKFksvnvkaszIG4Qkqq+DyN0wug3wpAVUAI/eaydf/mDFIpH7Gvlp0+WgpP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2450
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDE4LjA1LjIxIHVtIDIwOjA5IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4gT24gMjAy
MS0wNS0xOCAyOjAyIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE4LjA1LjIx
IHVtIDE5OjQzIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+PiBPbiAyMDIxLTA1LTE4IDEy
OjMzIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4gQW0gMTguMDUuMjEgdW0gMTg6
MTcgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Pj4KPj4+Pj4KPj4+Pj4gT24gMjAyMS0w
NS0xOCAxMToxNSBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+Pj4gQW0gMTguMDUu
MjEgdW0gMTc6MDMgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Pj4+Pgo+Pj4+Pj4+IE9u
IDIwMjEtMDUtMTggMTA6MDcgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4+Pj4g
SW4gYSBzZXBhcmF0ZSBkaXNjdXNzaW9uIHdpdGggRGFuaWVsIHdlIG9uY2UgbW9yZSBpdGVyYXRl
ZCBvdmVyIAo+Pj4+Pj4+PiB0aGUgZG1hX3Jlc3YgcmVxdWlyZW1lbnRzIGFuZCBJIGNhbWUgdG8g
dGhlIGNvbmNsdXNpb24gdGhhdCAKPj4+Pj4+Pj4gdGhpcyBhcHByb2FjaCBoZXJlIHdvbid0IHdv
cmsgcmVsaWFibGUuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFRoZSBwcm9ibGVtIGlzIGFzIGZvbGxvd2lu
ZzoKPj4+Pj4+Pj4gMS4gZGV2aWNlIEEgc2NoZWR1bGVzIHNvbWUgcmVuZGVyaW5nIHdpdGggaW50
byBhIGJ1ZmZlciBhbmQgCj4+Pj4+Pj4+IGV4cG9ydHMgaXQgYXMgRE1BLWJ1Zi4KPj4+Pj4+Pj4g
Mi4gZGV2aWNlIEIgaW1wb3J0cyB0aGUgRE1BLWJ1ZiBhbmQgd2FudHMgdG8gY29uc3VtZSB0aGUg
Cj4+Pj4+Pj4+IHJlbmRlcmluZywgZm9yIHRoZSB0aGUgZmVuY2Ugb2YgZGV2aWNlIEEgaXMgcmVw
bGFjZWQgd2l0aCBhIG5ldyAKPj4+Pj4+Pj4gb3BlcmF0aW9uLgo+Pj4+Pj4+PiAzLiBkZXZpY2Ug
QiBpcyBob3QgcGx1Z2dlZCBhbmQgdGhlIG5ldyBvcGVyYXRpb24gY2FuY2VsZWQvbmV3ZXIgCj4+
Pj4+Pj4+IHNjaGVkdWxlZC4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gVGhlIHByb2JsZW0gaXMgbm93IHRo
YXQgd2UgY2FuJ3QgZG8gdGhpcyBzaW5jZSB0aGUgb3BlcmF0aW9uIG9mIAo+Pj4+Pj4+PiBkZXZp
Y2UgQSBpcyBzdGlsbCBydW5uaW5nIGFuZCBieSBzaWduYWxpbmcgb3VyIGZlbmNlcyB3ZSBydW4g
Cj4+Pj4+Pj4+IGludG8gdGhlIHByb2JsZW0gb2YgcG90ZW50aWFsIG1lbW9yeSBjb3JydXB0aW9u
Lgo+Pj4+Pgo+Pj4+PiBCeSBzaWduYWxpbmcgc19mZW5jZS0+ZmluaXNoZWQgb2YgdGhlIGNhbmNl
bGVkIG9wZXJhdGlvbiBmcm9tIHRoZQo+Pj4+PiByZW1vdmVkIGRldmljZSBCIHdlIGluIGZhY3Qg
Y2F1c2UgbWVtb3J5IGNvcnJ1cHRpb24gZm9yIHRoZSAKPj4+Pj4gdW5jb21wbGV0ZWQKPj4+Pj4g
am9iIHN0aWxsIHJ1bm5pbmcgb24gZGV2aWNlIEEgPyBCZWNhdXNlIHRoZXJlIGlzIHNvbWVvbmUg
d2FpdGluZyB0bwo+Pj4+PiByZWFkIHdyaXRlIGZyb20gdGhlIGltcG9ydGVkIGJ1ZmZlciBvbiBk
ZXZpY2UgQiBhbmQgaGUgb25seSB3YWl0cyBmb3IKPj4+Pj4gdGhlIHNfZmVuY2UtPmZpbmlzaGVk
IG9mIGRldmljZSBCIHdlIHNpZ25hbGVkCj4+Pj4+IGluIGRybV9zY2hlZF9lbnRpdHlfa2lsbF9q
b2JzID8KPj4+Pgo+Pj4+IEV4YWN0bHkgdGhhdCwgeWVzLgo+Pj4+Cj4+Pj4gSW4gb3RoZXIgd29y
ZHMgd2hlbiB5b3UgaGF2ZSBhIGRlcGVuZGVuY3kgY2hhaW4gbGlrZSBBLT5CLT5DIHRoZW4gCj4+
Pj4gbWVtb3J5IG1hbmFnZW1lbnQgb25seSB3YWl0cyBmb3IgQyBiZWZvcmUgZnJlZWluZyB1cCB0
aGUgbWVtb3J5IGZvciAKPj4+PiBleGFtcGxlLgo+Pj4+Cj4+Pj4gV2hlbiBDIG5vdyBzaWduYWxl
ZCBiZWNhdXNlIHRoZSBkZXZpY2UgaXMgaG90LXBsdWdnZWQgYmVmb3JlIEEgb3IgQiAKPj4+PiBh
cmUgZmluaXNoZWQgdGhleSBhcmUgZXNzZW50aWFsbHkgYWNjZXNzaW5nIGZyZWVkIHVwIG1lbW9y
eS4KPj4+Cj4+PiBCdXQgZGlkbid0IEMgaW1wb3J0ZWQgdGhlIEJPIGZvcm0gQiBvciBBIGluIHRo
aXMgY2FzZSA/IFdoeSB3b3VsZCBoZSBiZQo+Pj4gdGhlIG9uZSByZWxlYXNpbmcgdGhhdCBtZW1v
cnkgPyBIZSB3b3VsZCBiZSBqdXN0IGRyb3BwaW5nIGhpcyByZWZlcmVuY2UKPj4+IHRvIHRoZSBC
Tywgbm8gPwo+Pgo+PiBXZWxsIGZyZWVpbmcgdGhlIG1lbW9yeSB3YXMganVzdCBhbiBleGFtcGxl
LiBUaGUgQk8gY291bGQgYWxzbyBtb3ZlIAo+PiBiYWNrIHRvIFZSQU0gYmVjYXVzZSBvZiB0aGUg
ZHJvcHBlZCByZWZlcmVuY2UuCj4+Cj4+PiBBbHNvIGluIHRoZSBnZW5lcmFsIGNhc2UsCj4+PiBk
cm1fc2NoZWRfZW50aXR5X2ZpbmktPmRybV9zY2hlZF9lbnRpdHlfa2lsbF9qb2JzIHdoaWNoIGlz
Cj4+PiB0aGUgb25lIHdobyBzaWduYWxzIHRoZSAnQycgZmVuY2Ugd2l0aCBlcnJvciBjb2RlIGFy
ZSBhcyBmYXIKPj4+IGFzIEkgbG9va2VkIGNhbGxlZCBmcm9tIHdoZW4gdGhlIHVzZXIgb2YgdGhh
dCBCTyBpcyBzdG9wcGluZwo+Pj4gdGhlIHVzYWdlIGFueXdheSAoZS5nLiBkcm1fZHJpdmVyLnBv
c3RjbG9zZSBjYWxsYmFjayBmb3Igd2hlbiB1c2UKPj4+IHByb2Nlc3MgY2xvc2VzIGhpcyBkZXZp
Y2UgZmlsZSkgd2hvIHdvdWxkIHRoZW4gYWNjZXNzIGFuZCBjb3JydXB0Cj4+PiB0aGUgZXhwb3J0
ZWQgbWVtb3J5IG9uIGRldmljZSBBIHdoZXJlIHRoZSBqb2IgaGFzbid0IGNvbXBsZXRlZCB5ZXQg
Pwo+Pgo+PiBLZXkgcG9pbnQgaXMgdGhhdCBtZW1vcnkgbWFuYWdlbWVudCBvbmx5IHdhaXRzIGZv
ciB0aGUgbGFzdCBhZGRlZCAKPj4gZmVuY2UsIHRoYXQgaXMgdGhlIGRlc2lnbiBvZiB0aGUgZG1h
X3Jlc3Ygb2JqZWN0LiBIb3cgdGhhdCBoYXBwZW5zIGlzIAo+PiBpcnJlbGV2YW50Lgo+Pgo+PiBC
ZWNhdXNlIG9mIHRoaXMgd2UgYXQgbGVhc3QgbmVlZCB0byB3YWl0IGZvciBhbGwgZGVwZW5kZW5j
aWVzIG9mIHRoZSAKPj4gam9iIGJlZm9yZSBzaWduYWxpbmcgdGhlIGZlbmNlLCBldmVuIGlmIHdl
IGNhbmNlbCB0aGUgam9iIGZvciBzb21lIAo+PiByZWFzb24uCj4+Cj4+IENocmlzdGlhbi4KPgo+
IFdvdWxkIHRoaXMgYmUgdGhlIHJpZ2h0IHdheSB0byBkbyBpdCA/CgpZZXMsIGl0IGlzIGF0IGxl
YXN0IGEgc3RhcnQuIFF1ZXN0aW9uIGlzIGlmIHdlIGNhbiB3YWl0IGJsb2NraW5nIGhlcmUgb3Ig
Cm5vdC4KCldlIGluc3RhbGwgYSBjYWxsYmFjayBhIGJpdCBsb3dlciB0byBhdm9pZCBibG9ja2lu
Zywgc28gSSdtIHByZXR0eSBzdXJlIAp0aGF0IHdvbid0IHdvcmsgYXMgZXhwZWN0ZWQuCgpDaHJp
c3RpYW4uCgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRf
ZW50aXR5LmMgCj4gYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4g
aW5kZXggMmU5M2U4ODFiNjVmLi4xMGY3ODQ4NzRiNjMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9z
Y2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPiBAQCAtMjIzLDEwICsyMjMsMTQgQEAgc3RhdGljIHZv
aWQgZHJtX3NjaGVkX2VudGl0eV9raWxsX2pvYnMoc3RydWN0IAo+IGRybV9zY2hlZF9lbnRpdHkg
KmVudGl0eSkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqam9i
Owo+IMKgwqDCoMKgwqDCoMKgIGludCByOwo+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGRtYV9mZW5j
ZSAqZjsKPgo+IMKgwqDCoMKgwqDCoMKgIHdoaWxlICgoam9iID0gCj4gdG9fZHJtX3NjaGVkX2pv
YihzcHNjX3F1ZXVlX3BvcCgmZW50aXR5LT5qb2JfcXVldWUpKSkpIHsKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9mZW5jZSAqc19mZW5jZSA9IGpvYi0+
c19mZW5jZTsKPgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdoaWxlIChmID0gc2No
ZWQtPm9wcy0+ZGVwZW5kZW5jeShzY2hlZF9qb2IsIGVudGl0eSkpCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV9mZW5jZV93YWl0KGYpOwo+ICsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHJtX3NjaGVkX2ZlbmNlX3NjaGVkdWxlZChz
X2ZlbmNlKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hX2ZlbmNlX3NldF9l
cnJvcigmc19mZW5jZS0+ZmluaXNoZWQsIC1FU1JDSCk7Cj4KPiBBbmRyZXkKPgo+Cj4KPj4KPj4+
Cj4+PiBBbmRyZXkKPj4+Cj4+Pj4KPj4+PiBDaHJpc3RpYW4uCj4+Pj4KPj4+Pj4KPj4+Pj4gQW5k
cmV5Cj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IEkgYW0gbm90IHN1cmUgdGhpcyBwcm9i
bGVtIHlvdSBkZXNjcmliZSBhYm92ZSBpcyByZWxhdGVkIHRvIHRoaXMgCj4+Pj4+Pj4gcGF0Y2gu
Cj4+Pj4+Pgo+Pj4+Pj4gV2VsbCBpdCBpcyBraW5kIG9mIHJlbGF0ZWQuCj4+Pj4+Pgo+Pj4+Pj4+
IEhlcmUgd2UgcHVyZWx5IGV4cGFuZCB0aGUgY3JpdGVyaWEgZm9yIHdoZW4gc2NoZWRfZW50aXR5
IGlzCj4+Pj4+Pj4gY29uc2lkZXJlZCBpZGxlIGluIG9yZGVyIHRvIHByZXZlbnQgYSBoYW5nIG9u
IGRldmljZSByZW1vdmUuCj4+Pj4+Pgo+Pj4+Pj4gQW5kIGV4YWN0bHkgdGhhdCBpcyBwcm9ibGVt
YXRpYy4gU2VlIHRoZSBqb2JzIG9uIHRoZSBlbnRpdHkgbmVlZCAKPj4+Pj4+IHRvIGNsZWFubHkg
d2FpdCBmb3IgdGhlaXIgZGVwZW5kZW5jaWVzIGJlZm9yZSB0aGV5IGNhbiBiZSBjb21wbGV0ZWQu
Cj4+Pj4+Pgo+Pj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9raWxsX2pvYnMoKSBpcyBhbHNvIG5vdCBo
YW5kbGluZyB0aGF0IGNvcnJlY3RseSAKPj4+Pj4+IGF0IHRoZSBtb21lbnQsIHdlIG9ubHkgd2Fp
dCBmb3IgdGhlIGxhc3Qgc2NoZWR1bGVkIGZlbmNlIGJ1dCBub3QgCj4+Pj4+PiBmb3IgdGhlIGRl
cGVuZGVuY2llcyBvZiB0aGUgam9iLgo+Pj4+Pj4KPj4+Pj4+PiBXZXJlIHlvdSBhZGRyZXNzaW5n
IHRoZSBwYXRjaCBmcm9tIHllc3RlcmRheSBpbiB3aGljaCB5b3UgY29tbWVudGVkCj4+Pj4+Pj4g
dGhhdCB5b3UgZm91bmQgYSBwcm9ibGVtIHdpdGggaG93IHdlIGZpbmlzaCBmZW5jZXMgPyBJdCB3
YXMKPj4+Pj4+PiAnW1BBVENIIHY3IDEyLzE2XSBkcm0vYW1kZ3B1OiBGaXggaGFuZyBvbiBkZXZp
Y2UgcmVtb3ZhbC4nCj4+Pj4+Pj4KPj4+Pj4+PiBBbHNvLCBpbiB0aGUgcGF0Y2ggc2VyaWVzIGFz
IGl0IGlzIG5vdyB3ZSBvbmx5IHNpZ25hbCBIVyBmZW5jZXMgCj4+Pj4+Pj4gZm9yIHRoZQo+Pj4+
Pj4+IGV4dHJhY3RlZCBkZXZpY2UgQiwgd2UgYXJlIG5vdCB0b3VjaGluZyBhbnkgb3RoZXIgZmVu
Y2VzLiBJbiAKPj4+Pj4+PiBmYWN0IGFzIHlvdQo+Pj4+Pj4+IG1heSByZW1lbWJlciwgSSBkcm9w
cGVkIGFsbCBuZXcgbG9naWMgdG8gZm9yY2luZyBmZW5jZSAKPj4+Pj4+PiBjb21wbGV0aW9uIGlu
Cj4+Pj4+Pj4gdGhpcyBwYXRjaCBzZXJpZXMgYW5kIG9ubHkgY2FsbCAKPj4+Pj4+PiBhbWRncHVf
ZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24KPj4+Pj4+PiBmb3IgdGhlIEhXIGZlbmNlcyBv
ZiB0aGUgZXh0cmFjdGVkIGRldmljZSBhcyBpdCdzIGRvbmUgdG9kYXkgCj4+Pj4+Pj4gYW55d2F5
Lgo+Pj4+Pj4KPj4+Pj4+IFNpZ25hbGluZyBoYXJkd2FyZSBmZW5jZXMgaXMgdW5wcm9ibGVtYXRp
YyBzaW5jZSB0aGV5IGFyZSBlbWl0dGVkIAo+Pj4+Pj4gd2hlbiB0aGUgc29mdHdhcmUgc2NoZWR1
bGluZyBpcyBhbHJlYWR5IGNvbXBsZXRlZC4KPj4+Pj4+Cj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+
Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gTm90IHN1
cmUgaG93IHRvIGhhbmRsZSB0aGF0IGNhc2UuIE9uZSBwb3NzaWJpbGl0eSB3b3VsZCBiZSB0byAK
Pj4+Pj4+Pj4gd2FpdCBmb3IgYWxsIGRlcGVuZGVuY2llcyBvZiB1bnNjaGVkdWxlZCBqb2JzIGJl
Zm9yZSBzaWduYWxpbmcgCj4+Pj4+Pj4+IHRoZWlyIGZlbmNlcyBhcyBjYW5jZWxlZC4KPj4+Pj4+
Pj4KPj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBBbSAxMi4wNS4yMSB1bSAx
NjoyNiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+Pj4+Pj4gUHJvYmxlbTogSWYgc2No
ZWR1bGVyIGlzIGFscmVhZHkgc3RvcHBlZCBieSB0aGUgdGltZSBzY2hlZF9lbnRpdHkKPj4+Pj4+
Pj4+IGlzIHJlbGVhc2VkIGFuZCBlbnRpdHkncyBqb2JfcXVldWUgbm90IGVtcHR5IEkgZW5jb3Vu
dHJlZAo+Pj4+Pj4+Pj4gYSBoYW5nIGluIGRybV9zY2hlZF9lbnRpdHlfZmx1c2guIFRoaXMgaXMg
YmVjYXVzZSAKPj4+Pj4+Pj4+IGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZQo+Pj4+Pj4+Pj4gbmV2
ZXIgYmVjb21lcyBmYWxzZS4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBGaXg6IEluIGRybV9zY2hlZF9m
aW5pIGRldGFjaCBhbGwgc2NoZWRfZW50aXRpZXMgZnJvbSB0aGUKPj4+Pj4+Pj4+IHNjaGVkdWxl
cidzIHJ1biBxdWV1ZXMuIFRoaXMgd2lsbCBzYXRpc2Z5IAo+Pj4+Pj4+Pj4gZHJtX3NjaGVkX2Vu
dGl0eV9pc19pZGxlLgo+Pj4+Pj4+Pj4gQWxzbyB3YWtldXAgYWxsIHRob3NlIHByb2Nlc3NlcyBz
dHVjayBpbiBzY2hlZF9lbnRpdHkgZmx1c2hpbmcKPj4+Pj4+Pj4+IGFzIHRoZSBzY2hlZHVsZXIg
bWFpbiB0aHJlYWQgd2hpY2ggd2FrZXMgdGhlbSB1cCBpcyBzdG9wcGVkIGJ5IAo+Pj4+Pj4+Pj4g
bm93Lgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IHYyOgo+Pj4+Pj4+Pj4gUmV2ZXJzZSBvcmRlciBvZiBk
cm1fc2NoZWRfcnFfcmVtb3ZlX2VudGl0eSBhbmQgbWFya2luZwo+Pj4+Pj4+Pj4gc19lbnRpdHkg
YXMgc3RvcHBlZCB0byBwcmV2ZW50IHJlaW5zZXJpb24gYmFjayB0byBycSBkdWUKPj4+Pj4+Pj4+
IHRvIHJhY2UuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gdjM6Cj4+Pj4+Pj4+PiBEcm9wIGRybV9zY2hl
ZF9ycV9yZW1vdmVfZW50aXR5LCBvbmx5IG1vZGlmeSBlbnRpdHktPnN0b3BwZWQKPj4+Pj4+Pj4+
IGFuZCBjaGVjayBmb3IgaXQgaW4gZHJtX3NjaGVkX2VudGl0eV9pc19pZGxlCj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92
c2t5QGFtZC5jb20+Cj4+Pj4+Pj4+PiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+PiDCoCBkcml2ZXJz
L2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIHzCoCAzICsrLQo+Pj4+Pj4+Pj4gwqAg
ZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmPCoMKgIHwgMjQgCj4+Pj4+Pj4+
PiArKysrKysrKysrKysrKysrKysrKysrKysKPj4+Pj4+Pj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwg
MjYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIAo+Pj4+Pj4+
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+Pj4+Pj4+PiBp
bmRleCAwMjQ5Yzc0NTAxODguLjJlOTNlODgxYjY1ZiAxMDA2NDQKPj4+Pj4+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPj4+Pj4+Pj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPj4+Pj4+Pj4+IEBAIC0xMTYs
NyArMTE2LDggQEAgc3RhdGljIGJvb2wgCj4+Pj4+Pj4+PiBkcm1fc2NoZWRfZW50aXR5X2lzX2lk
bGUoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkKPj4+Pj4+Pj4+IMKgwqDCoMKgwqAg
cm1iKCk7IC8qIGZvciBsaXN0X2VtcHR5IHRvIHdvcmsgd2l0aG91dCBsb2NrICovCj4+Pj4+Pj4+
PiDCoMKgwqDCoMKgIGlmIChsaXN0X2VtcHR5KCZlbnRpdHktPmxpc3QpIHx8Cj4+Pj4+Pj4+PiAt
IHNwc2NfcXVldWVfY291bnQoJmVudGl0eS0+am9iX3F1ZXVlKSA9PSAwKQo+Pj4+Pj4+Pj4gKyBz
cHNjX3F1ZXVlX2NvdW50KCZlbnRpdHktPmpvYl9xdWV1ZSkgPT0gMCB8fAo+Pj4+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGVudGl0eS0+c3RvcHBlZCkKPj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gdHJ1ZTsKPj4+Pj4+Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+Pj4+Pj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIAo+
Pj4+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+Pj4+Pj4+
Pj4gaW5kZXggOGQxMjExZTg3MTAxLi5hMmE5NTM2OTNiNDUgMTAwNjQ0Cj4+Pj4+Pj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+Pj4+Pj4+Pj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPj4+Pj4+Pj4+IEBAIC04OTgs
OSArODk4LDMzIEBAIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2luaXQpOwo+Pj4+Pj4+Pj4gwqDC
oCAqLwo+Pj4+Pj4+Pj4gwqAgdm9pZCBkcm1fc2NoZWRfZmluaShzdHJ1Y3QgZHJtX2dwdV9zY2hl
ZHVsZXIgKnNjaGVkKQo+Pj4+Pj4+Pj4gwqAgewo+Pj4+Pj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgZHJt
X3NjaGVkX2VudGl0eSAqc19lbnRpdHk7Cj4+Pj4+Pj4+PiArwqDCoMKgIGludCBpOwo+Pj4+Pj4+
Pj4gKwo+Pj4+Pj4+Pj4gwqDCoMKgwqDCoCBpZiAoc2NoZWQtPnRocmVhZCkKPj4+Pj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBrdGhyZWFkX3N0b3Aoc2NoZWQtPnRocmVhZCk7Cj4+Pj4+Pj4+PiAr
wqDCoMKgIGZvciAoaSA9IERSTV9TQ0hFRF9QUklPUklUWV9DT1VOVCAtIDE7IGkgPj0gCj4+Pj4+
Pj4+PiBEUk1fU0NIRURfUFJJT1JJVFlfTUlOOyBpLS0pIHsKPj4+Pj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgZHJtX3NjaGVkX3JxICpycSA9ICZzY2hlZC0+c2NoZWRfcnFbaV07Cj4+Pj4+
Pj4+PiArCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFycSkKPj4+Pj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIHNwaW5fbG9jaygmcnEtPmxvY2spOwo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGxpc3RfZm9yX2VhY2hfZW50cnkoc19lbnRpdHksICZycS0+ZW50aXRpZXMsIGxpc3QpCj4+Pj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIFByZXZlbnRzIHJlaW5zZXJ0aW9uIGFuZCBtYXJrcyBqb2JfcXVldWUgYXMg
aWRsZSwKPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpdCB3aWxsIHJlbW92
ZWQgZnJvbSBycSBpbiBkcm1fc2NoZWRfZW50aXR5X2ZpbmkKPj4+Pj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKiBldmVudHVhbGx5Cj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICovCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzX2VudGl0eS0+c3Rv
cHBlZCA9IHRydWU7Cj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJnJxLT5s
b2NrKTsKPj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+ICvCoMKgwqAgfQo+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+
Pj4gK8KgwqDCoCAvKiBXYWtldXAgZXZlcnlvbmUgc3R1Y2sgaW4gZHJtX3NjaGVkX2VudGl0eV9m
bHVzaCBmb3IgCj4+Pj4+Pj4+PiB0aGlzIHNjaGVkdWxlciAqLwo+Pj4+Pj4+Pj4gK8KgwqDCoCB3
YWtlX3VwX2FsbCgmc2NoZWQtPmpvYl9zY2hlZHVsZWQpOwo+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4g
wqDCoMKgwqDCoCAvKiBDb25maXJtIG5vIHdvcmsgbGVmdCBiZWhpbmQgYWNjZXNzaW5nIGRldmlj
ZSAKPj4+Pj4+Pj4+IHN0cnVjdHVyZXMgKi8KPj4+Pj4+Pj4+IGNhbmNlbF9kZWxheWVkX3dvcmtf
c3luYygmc2NoZWQtPndvcmtfdGRyKTsKPj4+Pj4+Pj4KPj4+Pj4+Cj4+Pj4KPj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
