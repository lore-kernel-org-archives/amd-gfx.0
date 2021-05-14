Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A08CC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 16:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABAA61444
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 16:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABAA61444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2566E1F6;
	Fri, 14 May 2021 16:13:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F25F6E1F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 16:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7YRIuQ1hq4jbxVEkr0p0izANPHXUMKvxp45ENkbpaNk06oVc4skKcWyRDco8N1K7gJaOq29Vrm8WT5eq90tgxS9eNy/JeOBIP3DJZ7/HexwqyKwNa8fl+nIuyeiB1UO3WnM/I50K1ZPesDUh0loVeayokFSHVjT9RWUfC79O3kJg+X8vzGNUDkdVqVNgolMOOKavjSV7NmHHmF81SYE2AsLr+5/3xS0DAxKMGtGFbit3FYIgfgqlTMqEUciZTuhjN8PmCvlbtWz40SWqyTV5LcfpjaKI58B1ogOefX0MfuFCwcXT3+wHgZGE2DSfo5km/aAcwxVY178D/n1/nt7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK8qekwy2f9bFJB4kO0cb3BrVgF98N+bwmWWorNvX3M=;
 b=IXBovrGvMakUGwGQdb538OW4P4o9NQV+xITYepQ/MSMLOeg2efARUY3YTBHIs4rhoR6rgOiZetDLgsrvmXG6rBtLOVyhO26RIcADtPdBG3pFXQIjGrjvMiiQIaH3fDcGzSPHuOowP6Kl0XNxtJSjHws9zfJToxMky1JgzLvS3IxV9rmgpIqLeKhLExQrr1S0+9sKDf826fmtsaZ2ot9noeEbNZfZLujvgQn/TpzFoAoQQLsOt/mM4x46Ccn4W5CtZQ5qlLY9vqVhtKYvZzJ+qBSgRRllEV2ELY6k8+OOhNyHqhQSGI5tHMzoGvNloTa8DV8AKMVcbeBLGNxaEoLcHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK8qekwy2f9bFJB4kO0cb3BrVgF98N+bwmWWorNvX3M=;
 b=Mp9mgVdJ+JN7Z4Z3gZtrgXOL11/2XYOvgwnrUe7hdY6NgM2LyKkudj+u9RrdDr68YA2sc4ZWBdtWGk0rHrSlqkjaRtjZ1O8RjaabipbsbG8tN4K1vCEa/HokTzC9GqifSynAYa5+LMgRvizikJBbyVmtCKq7JRkmPWJBgG1JAj0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 16:12:55 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 16:12:55 +0000
Subject: Re: [PATCH v2 2/2] drm/amdkfd: heavy-weight flush TLB after unmap
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210513165855.16395-2-Philip.Yang@amd.com>
 <20210514144222.24206-1-Philip.Yang@amd.com>
 <d5fba451-f75b-b77c-7fbf-a289914e97e5@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <fedfd1b3-3f18-dda0-c189-fd7a0675beee@amd.com>
Date: Fri, 14 May 2021 12:12:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <d5fba451-f75b-b77c-7fbf-a289914e97e5@gmail.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 16:12:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5421889-2b0d-4ede-7a1f-08d916f32225
X-MS-TrafficTypeDiagnostic: BN9PR12MB5161:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB516176F988910D27A0D6A53C92509@BN9PR12MB5161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKMIa2Je6HAmaKN4QU8JLLi4PNDLw5gQRf6Ac13ySmBIpErku8Kj1kogPg49Cnk41O5vvRpP7vP4UnBnUjd5MDP3/P6ZlV3n8KBK/Qq4i5MK0QZMx27j8nb3r6u3O+eT9T9g6n+Vcs3WKquS6hqZK1pX1W5L/aOR7jdRX7zlloEd3XyFync8naea7IE/QLBDuqrAmi4+Q/CXOdSqaveHon3XtATlY2fKSva8aC2SxNQvgO8smybwmik8ubLQxlv0/XHZ6Ax8Cv3JmqwzQ6rJVE97YiC3UAKUeSSDcPtpCSRGhW4WyBh/ch0CgLhx9rqfz+byzSAzYYNb9sCutSemhOysdkzQMVoO8kWsXWUwhBEz5TxD+J6+rzjmTWzTSmS/kIOG2nBQx28Kkq+NODPWB97ChTwD7qYsriMtxu2p4CKWtUo/2OZ62c5F+mb3YZLVJAcQmVtnWEiBihIjyuTnw3X+CWtHxLyb7gqyf713JW+twi6Q3VaR8+GJkXWuWO2ajErtkKTlm+sLNZyUteJpmPZ31Hz+dcYcHEAPuSxajxG4pS8ohmpRB6sT5/V9gfiaYzvbSgFUUUbxLHKnQ/u6lSqBYNim/UYdCsH9VW2WZiyhTXXikE7u74LS0GfaztxaTcuYEitwiJtFUsozg2Lu0Dl/LH2vH3beODTkZBGtsViUcQo4IfXlrUVVxP8XROzpuxkmNCENe+GaSa89seEdtTMVml3Rjg0aiYNSWeVC99itilLll6c2aAtf58YEk/e8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(316002)(16576012)(38100700002)(83380400001)(66556008)(2616005)(110136005)(66476007)(26005)(5660300002)(44832011)(966005)(478600001)(8936002)(36756003)(2906002)(16526019)(86362001)(31686004)(8676002)(6486002)(186003)(66946007)(31696002)(956004)(16393002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WmxkbDIwRUJVUmdyS2lPanRucGl4aUpScTBLcWdzTWx1VksyMko3MWpySDdv?=
 =?utf-8?B?MkJMaE02NnBLUURjS1lFQ3JQNkYyN1Rub0xvLzBSZGZkVmdSZDlZVkhMdkhL?=
 =?utf-8?B?M0JDcXJRNFU0bFdkcjEvT3ExM3FzdXlFMkVvVFAzVS80bXZDSWlJRWZURjJL?=
 =?utf-8?B?REhsYTZoaW9sM1gwUkVIOXp1b3hrUjV4aGc2Qmp6NlRBZjBpR3JSUzQyaFZi?=
 =?utf-8?B?OXhtb3c0Tm5EV2hBbTNLYTQxUklNdm4wY0oxL2VpMldzdFZ2aVN1WHZqckdR?=
 =?utf-8?B?S1liNUk0OHgzU3pVTVVwT0xQK1UxVWFtNHExaDlScHhuSWhmZ2lVdTY4MzVv?=
 =?utf-8?B?b1dIS3cvdWhDLzEzZ1hMT0ZyS2VlbEt2NEkrcTQvVmxTbTlhYkIzTWlCbUV6?=
 =?utf-8?B?NE1KMEpLdzFzUWE3QWhMWmdCNU5POHplV0ZxeTluMVl4ZDcrSnRJTWJmOEcz?=
 =?utf-8?B?czVDSjhWNVBOUTRZajNtVkRtUzdtd1ZOSHNrbmJSeVVHQlNHL0JldE1aT1c5?=
 =?utf-8?B?YlJlUE1Ma0dhOXFFaHF6YVBSSVJoK2R1SGhOeENUQjRCZGc0NjhMbm9ObU1O?=
 =?utf-8?B?QmtGcWpLS2NpVlN1eW1ITm9rS1lMMVNUdGErclJXc0lWNHFYQS9LRHluc3BN?=
 =?utf-8?B?eUlFMHNIWHdmRkNaWXYzQVc4ZDdLYTRoRGEvdEN5MlJ2MDlUVCt3OStSMXdF?=
 =?utf-8?B?ZTV5ZlZlaUs4QzNkYTJiTk1UampQSE93OHBHUzdDOWJkdXdLS3p2TVNVVU5i?=
 =?utf-8?B?QUxBc2E0L1JYbm9pZnpNbzNRRnF2c1hwT0JmcVNHKzF2WWhmL2ZmdDY5Z3RP?=
 =?utf-8?B?Skt0SjMzWlB1ZFhPSFE4TDhBZ05UMXhtMzY2eFJnL1hiRytYTTQ2dllVdHFC?=
 =?utf-8?B?aXNobGtDdHpuTUM4b3ROMUdueXMyT2pTUTRxSzM1bEp6MSs2ZnRFdHAxdS9M?=
 =?utf-8?B?azhMUDFxUkNaMTV5RzloY1VQTkdEMTYvd1YxN1BLS0VtM2hqRksybmtwUVNR?=
 =?utf-8?B?aE94OVo2T01FQkg1TDc4NCtPcGUzQUZpaVFnc1gzYUlSV3c2R25WNVFLMEhR?=
 =?utf-8?B?eEs2MTlzcnkrVFUxRmgvTmNicGtHa0VTUFlmRVpzQWNvSWJIN0d3RFZuTTNV?=
 =?utf-8?B?MFNhUU1acGEwbzUySVV6dXJpb1FTaWQwR01aRUxHQzhWQTdjaFh6R3hYM2VE?=
 =?utf-8?B?OVFWcXNRZkdBRlBzUEZmc3h1OXNUeVFGZk9DbTFnRWlqZXBwQVhiTGdqVVp6?=
 =?utf-8?B?TEZnSDJ2cU1lSTFRMkhOaSt6WVBLb2tFM0NDS0FQVksyc3djemVhWUVLVnFx?=
 =?utf-8?B?M2MvY3VsemNqWUluOHBoRHU5aUE4UVpXcXpEMmduYWdKaW5mL3YvZTdVbGlF?=
 =?utf-8?B?VVNNa21LL0NMamFja1JBOE1GYTNxREQwckd1Rk5EOTZwYmNxSXVrOFNHZUts?=
 =?utf-8?B?WUtpZFQ0TURuSkFsZCtLT05DUVM4c0JNWGNQd0xnN3RFTGRBZndXVm16dXV5?=
 =?utf-8?B?U1ZsZmNETmZXQUZienNYekZVanVkNTI2NkpMMDdlREpsWUNraWYxUUNacmVL?=
 =?utf-8?B?Lzh0eW0zSDBUYVduQVRTUld3ejQwdGVFR2pZR1QxNTdUcUR2Tk9hUk5uUEI5?=
 =?utf-8?B?V0wrWUhlR1BidHJTS253RiszZ2t6dlRIY2JDNk8xS1RKU0JwVHNPWko0bmRB?=
 =?utf-8?B?QWVIRy9IS0tvZHRvT0tUMk9weTJrUmZTdyt6VGRQSkxlNVY0Q05lN3RXTlZF?=
 =?utf-8?B?RGh6ZGZMblpiZisxSEtaVzZzUTlMd2xwcHh3cCtaamN1UndoRXRwYmN3YkRj?=
 =?utf-8?B?S3lPNWFLZkRrUmw4eXBtZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5421889-2b0d-4ede-7a1f-08d916f32225
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 16:12:55.8726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVGuksZ0BJrbWSlakb24HercDVRkAo//urGpneWhgmNZEZK5CJihN0rL9I4yLPZb0Nrm8+tuRIGBXZv2nVedIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNS0xNCB1bSAxMToxNCBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiBB
bSAxNC4wNS4yMSB1bSAxNjo0MiBzY2hyaWViIFBoaWxpcCBZYW5nOgo+PiBOZWVkIGRvIGEgaGVh
dnktd2VpZ2h0IFRMQiBmbHVzaCB0byBtYWtlIHN1cmUgd2UgaGF2ZSBubyBtb3JlIGRpcnR5IGRh
dGEKPj4gaW4gdGhlIGNhY2hlIGZvciB0aGUgdW5tYXBwZWQgcGFnZXMuCj4+Cj4+IERlZmluZSBl
bnVtIFRMQl9GTFVTSF9UWVBFLCBhZGQgZmx1c2hfdHlwZSBwYXJhbWV0ZXIgdG8KPj4gYW1kZ3B1
X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3Bhc2lkLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXAg
WWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KPgo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxp
bmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgoKPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIHwgNCArKy0tCj4+IMKgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaCB8IDkgKysrKysrKystCj4+IMKgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmPCoMKgIHwgMiArLQo+PiDCoCBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmPCoMKgwqDCoMKgwqAgfCA0ICsrLS0KPj4g
wqAgNCBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5j
Cj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4+IGluZGV4
IDVmNjY5NmEzYzc3OC4uYmZhYjJmOWZkZDE3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4+IEBAIC02NzAsMTAgKzY3MCwxMCBAQCBpbnQgYW1k
Z3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3ZtaWQoc3RydWN0Cj4+IGtnZF9kZXYgKmtnZCwgdWlu
dDE2X3Qgdm1pZCkKPj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+PiDCoCAtaW50IGFt
ZGdwdV9hbWRrZmRfZmx1c2hfZ3B1X3RsYl9wYXNpZChzdHJ1Y3Qga2dkX2RldiAqa2dkLAo+PiB1
aW50MTZfdCBwYXNpZCkKPj4gK2ludCBhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfcGFzaWQo
c3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDE2X3QKPj4gcGFzaWQsCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBUTEJfRkxVU0hfVFlQRSBmbHVzaF90
eXBlKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKilrZ2Q7Cj4+IC3CoMKgwqAgY29uc3QgdWludDMyX3QgZmx1
c2hfdHlwZSA9IDA7Cj4+IMKgwqDCoMKgwqAgYm9vbCBhbGxfaHViID0gZmFsc2U7Cj4+IMKgIMKg
wqDCoMKgwqAgaWYgKGFkZXYtPmZhbWlseSA9PSBBTURHUFVfRkFNSUxZX0FJKQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4+IGluZGV4IDMxM2VlNDli
OWYxNy4uZjRkZTUwZGUzNTliIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkLmgKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZC5oCj4+IEBAIC0zNiw2ICszNiwxMiBAQAo+PiDCoCDCoCBleHRlcm4gdWlu
dDY0X3QgYW1kZ3B1X2FtZGtmZF90b3RhbF9tZW1fc2l6ZTsKPj4gwqAgK2VudW0gVExCX0ZMVVNI
X1RZUEUgewo+PiArwqDCoMKgIFRMQl9GTFVTSF9MRUdBQ1kgPSAwLAo+PiArwqDCoMKgIFRMQl9G
TFVTSF9MSUdIVFdFSUdIVCwKPj4gK8KgwqDCoCBUTEJfRkxVU0hfSEVBVllXRUlHSFQKPj4gK307
Cj4+ICsKPj4gwqAgc3RydWN0IGFtZGdwdV9kZXZpY2U7Cj4+IMKgIMKgIHN0cnVjdCBrZmRfYm9f
dmFfbGlzdCB7Cj4+IEBAIC0xMzUsNyArMTQxLDggQEAgaW50IGFtZGdwdV9hbWRrZmRfc3VibWl0
X2liKHN0cnVjdCBrZ2RfZGV2ICprZ2QsCj4+IGVudW0ga2dkX2VuZ2luZV90eXBlIGVuZ2luZSwK
Pj4gwqAgdm9pZCBhbWRncHVfYW1ka2ZkX3NldF9jb21wdXRlX2lkbGUoc3RydWN0IGtnZF9kZXYg
KmtnZCwgYm9vbCBpZGxlKTsKPj4gwqAgYm9vbCBhbWRncHVfYW1ka2ZkX2hhdmVfYXRvbWljc19z
dXBwb3J0KHN0cnVjdCBrZ2RfZGV2ICprZ2QpOwo+PiDCoCBpbnQgYW1kZ3B1X2FtZGtmZF9mbHVz
aF9ncHVfdGxiX3ZtaWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDE2X3QKPj4gdm1pZCk7Cj4+
IC1pbnQgYW1kZ3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3Bhc2lkKHN0cnVjdCBrZ2RfZGV2ICpr
Z2QsIHVpbnQxNl90Cj4+IHBhc2lkKTsKPj4gK2ludCBhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90
bGJfcGFzaWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDE2X3QKPj4gcGFzaWQsCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBUTEJfRkxVU0hfVFlQ
RSBmbHVzaF90eXBlKTsKPj4gwqAgwqAgYm9vbCBhbWRncHVfYW1ka2ZkX2lzX2tmZF92bWlkKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIKPj4gdm1pZCk7Cj4+IMKgIGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+PiBpbmRleCA5ZDRmNTI3YmRhN2MuLjVi
NmM1NjY5YzAzZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3Byb2Nlc3MuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vz
cy5jCj4+IEBAIC0xODUzLDcgKzE4NTMsNyBAQCB2b2lkIGtmZF9mbHVzaF90bGIoc3RydWN0IGtm
ZF9wcm9jZXNzX2RldmljZSAqcGRkKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBkZC0+cXBkLnZtaWQpOwo+PiDCoMKgwqDCoMKg
IH0gZWxzZSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90
bGJfcGFzaWQoZGV2LT5rZ2QsCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHBkZC0+cHJvY2Vzcy0+cGFzaWQpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcGRkLT5wcm9jZXNzLT5wYXNpZCwgVExCX0ZMVVNIX0xFR0FD
WSk7Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCB9Cj4+IMKgIGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfc3ZtLmMKPj4gaW5kZXggYTUyZTQ1OTQ3ODVmLi5mMjkwMWU3YTk5M2UgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYwo+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPj4gQEAgLTExMjcsNyArMTEyNyw3IEBA
IHN2bV9yYW5nZV91bm1hcF9mcm9tX2dwdXMoc3RydWN0IHN2bV9yYW5nZQo+PiAqcHJhbmdlLCB1
bnNpZ25lZCBsb25nIHN0YXJ0LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGJyZWFrOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1k
Z3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3Bhc2lkKChzdHJ1Y3Qga2dkX2RldiAqKWFkZXYsCj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwLT5w
YXNpZCk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwLT5wYXNp
ZCwgVExCX0ZMVVNIX0hFQVZZV0VJR0hUKTsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIMKgwqDCoMKg
wqAgcmV0dXJuIHI7Cj4+IEBAIC0xMTgzLDcgKzExODMsNyBAQCBzdm1fcmFuZ2VfbWFwX3RvX2dw
dShzdHJ1Y3QgYW1kZ3B1X2RldmljZQo+PiAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sCj4+
IMKgIMKgwqDCoMKgwqDCoMKgwqDCoCBwID0gY29udGFpbmVyX29mKHByYW5nZS0+c3Ztcywgc3Ry
dWN0IGtmZF9wcm9jZXNzLCBzdm1zKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9hbWRr
ZmRfZmx1c2hfZ3B1X3RsYl9wYXNpZCgoc3RydWN0IGtnZF9kZXYgKilhZGV2LAo+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcC0+cGFzaWQpOwo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwLT5wYXNp
ZCwgVExCX0ZMVVNIX0xFR0FDWSk7Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCBvdXQ6Cj4+IMKgwqDC
oMKgwqAgcHJhbmdlLT5tYXBwaW5nLmJvX3ZhID0gTlVMTDsKPgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
