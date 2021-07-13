Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587BBC11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 15:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7846135F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 15:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7846135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C739889CF4;
	Tue, 13 Jul 2021 15:29:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A7A89CF4;
 Tue, 13 Jul 2021 15:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORK6isah1GfYVxi2PvNNxbWPn64Fo0K7SzgwzyMpn9iejnB/xWPKnnZSi6YU5cKkjYvo2U7aUTn+JJ2AmD3g/PCnDjRDBAstYYeYx2FQxXMG8I1IM9VZDvJLuQtvz3LY7y+d4/bJpAZcm0C9DiKfu5rn5QE1eonslae71WlSGCPMvdZsLUYdSNG1VUbx6y8E9pByc5eSuKFW8N3h40qK3xfgDAdBVeKZQZrn25GC8nfJKbZB3bouOZwPkscmdcTeI+X6wZBW/VchN1dvXkU5FHkv7W7zrY+j4514sChXBGuBaeNs6QFC3Wi9T485vkcVdE1KiJdfChPpCxVbp++Meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTw7qDWKrpZoCBCPmqWRV2Z9I40isJQ4wQCUCUt7klg=;
 b=eDYaQWut8hYVT5T/MrdvViHeaePVyBG/+EebXDpZOyY2kvMcrXY5bRWuVbuX2KtPJLfh+QLAyyqI0YihuUSDy+x/AHq3naEwGgICu+IFkJVCFrENVUiTaBxsJ5mOB9cbmZ+Hbarwu9uB40lei4h1e8pC7xbbfCjYSfRJQT43r70YdT9Hpqg1Tme7oRdbjgBm4Uldljk8djB9qLzKBj9npu9rupdiZyyayHdV0ztU2AiXRPK6B/PvS9AojXU707dE4dOU7NF+AHq7pgoEtq8VYcfCSLfkLlaQEx4LzxYn0SpqX7FqgBnjWrypsIqcee/rIK5uIEiue1ldhV6Ysq5Q/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTw7qDWKrpZoCBCPmqWRV2Z9I40isJQ4wQCUCUt7klg=;
 b=dMqAS2M/PBERmkRy0ESscdY+CSzX8C1GR4/NZMXB1UAOXBglBP09vq7Ntt404yWrfuSERjAtNJJhdPmFdXL75J7OHSFSZQYg41F7Mv3TCWv4dMaR+dFxHZpI2X29gO1nb7/d5eO07mMS79YMkdCyNBPG3AlgT1RKFHHOUDFhhLs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 15:29:19 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 15:29:19 +0000
Subject: Re: [PATCH v3 1/1] drm/ttm: Fix COW check
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20210712220636.475675-1-Felix.Kuehling@amd.com>
 <d617d831-7168-51a4-042e-e36a5af7761d@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a3b0c945-790f-944e-9af6-48fae77a1402@amd.com>
Date: Tue, 13 Jul 2021 11:29:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <d617d831-7168-51a4-042e-e36a5af7761d@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::12) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT1PR01CA0103.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 13 Jul 2021 15:29:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f4f94a4-f383-4547-ed5b-08d94612fbad
X-MS-TrafficTypeDiagnostic: BN9PR12MB5065:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB506574DD34CEBEF01648BB6C92149@BN9PR12MB5065.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: if74FRa6R5yuDD8DjIQYq60iS/ldxErYr40Vv8anW7p8Fye4IYU03op2DvIoaqM7KASeCf4iNVObHMLhULedPvx1joYxIwLjVQMBkMmdjO98woKPXCw9LO/bg4Fkk2ijbKa4ag2/I/6loI9MXBLxwZQWNewbC5Sf/nMBlyN6bEXYaEePenxzgE0694w2u1Ph/jTg6MsA+vCVTh3Jh7Q/96HNCkut0Lgitc9Bzu6+iuKPvbtqL+rh0vcbPgIxFEHrKaBTd3GTUwvIY4PekXgwBpAH2bU++9bS6yrjp6lRlgOmkqNOJXPEW+7AtEg9UjWF12rM8fCW/hDBselvuNH0tesXfL1rCNZnDAU23PBNm8mPt9MtvGztOKCxwWM4H/Td5L7BRcEZ2y4ptsMmLwVqW0mLqGC5n77h/DFeu4fMyD5qr2kpAStjZyjcPmioZDZUJRM9q1Q/VhVpg3PNjwnG3zkg7VT+g6hSUY9JIdsaVJmraob8RhWjGe0eFAETMmZLxiWG6/c00JktLcm3er+/fcI15yHMAGKh0Q0W6NN9zux4NMCrbbzGcX+jmI7F/VCYY1NVV5QgByxgWJqEgGn9VXHtQbQoRMoHsjrGj2bcjTMTQOTdEjK9UbezyZFgCiRk3NnGxU/VWBkl7nh2Sia76QqynlVroiQYh3CG9T1ij/V1zkyO4z2cBJ7035/PDsfLrQSons5yp2iIA78uwUUMV2UHnPUgWv6XhTusdHYP8MQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(66946007)(316002)(66556008)(26005)(2616005)(956004)(38100700002)(5660300002)(83380400001)(44832011)(6486002)(186003)(31686004)(66574015)(8676002)(66476007)(8936002)(86362001)(16576012)(31696002)(36756003)(4326008)(2906002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFWL0o0UzR5aTBTdms5T1lXVU40aERhdHlCekdmaldaY1kvN2pIcjJGWkp1?=
 =?utf-8?B?M2NGcEdXUmJvWUFGVmVEbDJhcElKYUdKZEUxRjkxOXVCNWdKWjdRQmppV0hv?=
 =?utf-8?B?NkdZZnFWazdOdmVSb3VlaUZwTi9zUjN5c1RLM0h5em51UXFjd1BBR2RtN1gx?=
 =?utf-8?B?TTZXOGhUdmo4c01RMlRjbnNsMytPR0F3WjhjYXk5ZG1XTXc5NERlQ3R6SjZM?=
 =?utf-8?B?Q2xxeVZTQmlqOCtFS1JaKytkYTdMWXQ1b2UxME1qWk1VR3YyQlR0NE9KWUR2?=
 =?utf-8?B?MlVmcC9JR2pBRVVTV3NBeXlDcmNRWGc2T29ZL0VWL3lEY3ZzenNaVmJGUlp2?=
 =?utf-8?B?WnRxc0tWMlJKQ3YwSERVY2M5NExtMnZxbVlqc2NQUWxHVTZJVnNkMUNzYUJx?=
 =?utf-8?B?UlFBblpSVDdRSFZLNHhzVTl4Tm5ubmV3MWR5NWxpNGIrV3Z6eS9oTTVoTWlq?=
 =?utf-8?B?TGxCcjM3WS9HUXRFbXV1S3FKdFEwalRnRnZoMUdPdTJaYkRpZUJ2YlBLV09Q?=
 =?utf-8?B?OU1qTzUvRHZBdE44THhWOHYyb1JVNklORll5bEE3Q09hd081SDRDM1dIaUhM?=
 =?utf-8?B?T0dxaFpTMmVRSEFuY0dRSSt1bnBaaHVORTVwRDJBMGZaeG55c3cxaHZDcjEx?=
 =?utf-8?B?Q3FiSE9HTkF3T2lubXE1eS91bVAwL0VsWG9HYUd0YWV1YVh3cW0vSkNpMHlU?=
 =?utf-8?B?RHFZQ0padnJYOHJoQ3lOQStLRHlEVERXbENOcnI2TXk3czNMVHpJL3FkTnNR?=
 =?utf-8?B?QU5FRlk5eXlicjFEQnByVW5OYkFsRDk1YW1CVzVaYVlXMlVWYUN5S1JuRmNU?=
 =?utf-8?B?SVhZaW9OL0dTL2tMVDZseFZRRTB6b3VVa2h1dEhwbytFcVJiU0g0aE9TZmVr?=
 =?utf-8?B?SGxkVkIzZ0ZGbEY0TEtIbFd2RTN4bC8yOUlsNVBiTFNTdFl4RnRXdTNnTXdy?=
 =?utf-8?B?MlRRZmVuWnVBdlM4ZmQ1d2tQTzVFakJYVnFzdWFhT1gxOHFJeUZ6Z2RVbzVk?=
 =?utf-8?B?cHdhVmtDNWZEbVVtLzZBbVFMTVFzNXhvZjBUUTBCQnRoWnRxSis5Y0QxT04z?=
 =?utf-8?B?WHg5ajJhaEorUlNJOFNhYzR1U0h4MWtaM2lBNnNvc2JKZXZ1NFV2K0pJVTRw?=
 =?utf-8?B?QXVWbndmVU1lUkZseHpkUngzcVVLSXNlNUI5SE50Z3FCR0FJSmd4MFBOd2dU?=
 =?utf-8?B?Mi84TEhIc1N5S1AxTzF3ak14bDVqQ3N3ZEQ0MGVFKy9VdFA1VlMvT0hPM1h3?=
 =?utf-8?B?UkdhVEd2cHJrRklRcTI0Mzd4MWs4TFdvOW14RCtRT1N5cTZFSktmRFMzY2Nj?=
 =?utf-8?B?RG1SYjk3cGl1YnljVzVjRktzb2NhRC9NelBvN0VIVmNGRkVGbkl0UE1tZkhV?=
 =?utf-8?B?anA5Z0VBeEdpbkxSQ3RPNzFjc3pQL0RtbGpiKzZ4dWRWdVU2ZGt4SGtvWTlN?=
 =?utf-8?B?OXc1MlpoYmNKUktsSXJCWXQwZGVGbGtESmlEeFlaRFlYcmo2ajJqNjZNdlVI?=
 =?utf-8?B?bElZRDhxVExocGIzbkdkSFR2VDA1SG9DbmxUUkFueHhid1ZZaWc4a2VFa21X?=
 =?utf-8?B?RSs1WGpCcWFRUEhwcm5yS0F6ZW5HbFBUYk5KQWtReWVpZVlHbEZjOFZpQThy?=
 =?utf-8?B?S0VzZzN1RzdsSE5sL1hIMUxhSzc4NEhCUUNrbHBFcmF0SXFrdDAwcDFkMkl6?=
 =?utf-8?B?TmllS2VXM1Q3dkpqYTBhUmVTQUhoQVJjSDdCSVRxMkxlQ0dSNGFjemsySmRh?=
 =?utf-8?Q?euWg5N8tsbvQHVdtXhwegqELIA5qpPvhKtW+EKS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4f94a4-f383-4547-ed5b-08d94612fbad
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 15:29:19.6775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHgekZEvgLaN4mPaHuHupcUOzfS0CQOp1vdyhI69awSfh2Ibo82cOJfDHhLERWE27ZHzlMNU+pggwHNrtrL5xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
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
Cc: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNy0xMyB1bSAyOjU3IGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Cj4K
PiBBbSAxMy4wNy4yMSB1bSAwMDowNiBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBLRkQgVGh1
bmsgbWFwcyBpbnZpc2libGUgVlJBTSBCT3Mgd2l0aCBQUk9UX05PTkUsIE1BUF9QUklWQVRFLgo+
PiBpc19jb3dfbWFwcGluZyByZXR1cm5zIHRydWUgZm9yIHRoZXNlIG1hcHBpbmdzLiBBZGQgYSBj
aGVjayBmb3IKPj4gdm1fZmxhZ3MgJiBWTV9XUklURSB0byBhdm9pZCBtbWFwIGZhaWx1cmVzIG9u
IHByaXZhdGUgcmVhZC1vbmx5IG9yCj4+IFBST1RfTk9ORSBtYXBwaW5ncy4KPj4KPj4gdjI6IHBy
b3RlY3QgYWdhaW5zdCBtcHJvdGVjdCBtYWtpbmcgYSBtYXBwaW5nIHdyaXRhYmxlIGFmdGVyIHRo
ZSBmYWN0Cj4+IHYzOiB1cGRhdGUgZHJpdmVyLXNwZWNpZmljIHZtX29wZXJhdGlvbnNfc3RydWN0
cwo+Pgo+PiBGaXhlczogZjkxMTQyYzYyMTYxICgiZHJtL3R0bTogbnVrZSBWTV9NSVhFRE1BUCBv
biBCTyBtYXBwaW5ncyB2MyIpCj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxp
eC5LdWVobGluZ0BhbWQuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Cj4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKVGhhbmsgeW91IQoKQWxleCwgdGhpcyBwYXRjaCBp
cyBhZ2FpbnN0IHlvdXIgdXBkYXRlZCBhbWQtc3RhZ2luZy1kcm0tbmV4dCBicmFuY2guClBsZWFz
ZSByZXBsYWNlIG15IHByZXZpb3VzIHZlcnNpb24gb2YgdGhlIHBhdGNoIHdpdGggdGhpcyBvbmUu
CgpUaGFua3MsCsKgIEZlbGl4CgoKPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dlbS5jwqAgfMKgIDMgKystCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9ub3V2
ZWF1L25vdXZlYXVfZ2VtLmPCoMKgwqAgfMKgIDMgKystCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2dlbS5jwqDCoMKgwqDCoCB8wqAgMyArKy0KPj4gwqAgZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fYm9fdm0uY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDE0ICsrKysrKysrKysrKyst
Cj4+IMKgIGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X3R0bV9nbHVlLmMgfMKgIDEgKwo+
PiDCoCBpbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCA0ICsrKysKPj4gwqAgNiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dlbS5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5j
Cj4+IGluZGV4IGIzNDA0YzQzYTkxMS4uMWFhNzUwYTZhNWQyIDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+IEBAIC03OSw3ICs3OSw4IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QKPj4gYW1kZ3B1X2dlbV92bV9vcHMgPSB7
Cj4+IMKgwqDCoMKgwqAgLmZhdWx0ID0gYW1kZ3B1X2dlbV9mYXVsdCwKPj4gwqDCoMKgwqDCoCAu
b3BlbiA9IHR0bV9ib192bV9vcGVuLAo+PiDCoMKgwqDCoMKgIC5jbG9zZSA9IHR0bV9ib192bV9j
bG9zZSwKPj4gLcKgwqDCoCAuYWNjZXNzID0gdHRtX2JvX3ZtX2FjY2Vzcwo+PiArwqDCoMKgIC5h
Y2Nlc3MgPSB0dG1fYm9fdm1fYWNjZXNzLAo+PiArwqDCoMKgIC5tcHJvdGVjdCA9IHR0bV9ib192
bV9tcHJvdGVjdAo+PiDCoCB9Owo+PiDCoCDCoCBzdGF0aWMgdm9pZCBhbWRncHVfZ2VtX29iamVj
dF9mcmVlKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqZ29iaikKPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZ2VtLmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vbm91
dmVhdS9ub3V2ZWF1X2dlbS5jCj4+IGluZGV4IDViMjc4NDUwNzVhMS4uMTY0ZWE1NjRiYjdhIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X2dlbS5jCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZ2VtLmMKPj4gQEAgLTcwLDcgKzcw
LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdAo+PiBub3V2ZWF1
X3R0bV92bV9vcHMgPSB7Cj4+IMKgwqDCoMKgwqAgLmZhdWx0ID0gbm91dmVhdV90dG1fZmF1bHQs
Cj4+IMKgwqDCoMKgwqAgLm9wZW4gPSB0dG1fYm9fdm1fb3BlbiwKPj4gwqDCoMKgwqDCoCAuY2xv
c2UgPSB0dG1fYm9fdm1fY2xvc2UsCj4+IC3CoMKgwqAgLmFjY2VzcyA9IHR0bV9ib192bV9hY2Nl
c3MKPj4gK8KgwqDCoCAuYWNjZXNzID0gdHRtX2JvX3ZtX2FjY2VzcywKPj4gK8KgwqDCoCAubXBy
b3RlY3QgPSB0dG1fYm9fdm1fbXByb3RlY3QKPj4gwqAgfTsKPj4gwqAgwqAgdm9pZAo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZ2VtLmMKPj4gYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9nZW0uYwo+PiBpbmRleCA0NThmOTJhNzA4ODcuLmMxOWFk
MDdlYjdiNSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZ2Vt
LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZ2VtLmMKPj4gQEAgLTc3
LDcgKzc3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdAo+PiBy
YWRlb25fZ2VtX3ZtX29wcyA9IHsKPj4gwqDCoMKgwqDCoCAuZmF1bHQgPSByYWRlb25fZ2VtX2Zh
dWx0LAo+PiDCoMKgwqDCoMKgIC5vcGVuID0gdHRtX2JvX3ZtX29wZW4sCj4+IMKgwqDCoMKgwqAg
LmNsb3NlID0gdHRtX2JvX3ZtX2Nsb3NlLAo+PiAtwqDCoMKgIC5hY2Nlc3MgPSB0dG1fYm9fdm1f
YWNjZXNzCj4+ICvCoMKgwqAgLmFjY2VzcyA9IHR0bV9ib192bV9hY2Nlc3MsCj4+ICvCoMKgwqAg
Lm1wcm90ZWN0ID0gdHRtX2JvX3ZtX21wcm90ZWN0Cj4+IMKgIH07Cj4+IMKgIMKgIHN0YXRpYyB2
b2lkIHJhZGVvbl9nZW1fb2JqZWN0X2ZyZWUoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpnb2JqKQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYwo+PiBiL2RyaXZl
cnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMKPj4gaW5kZXggZjU2YmU1YmMwODYxLi5mYjMyNWJh
ZDVkYjYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMKPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYwo+PiBAQCAtNTQyLDE3ICs1NDIs
MjkgQEAgaW50IHR0bV9ib192bV9hY2Nlc3Moc3RydWN0IHZtX2FyZWFfc3RydWN0Cj4+ICp2bWEs
IHVuc2lnbmVkIGxvbmcgYWRkciwKPj4gwqAgfQo+PiDCoCBFWFBPUlRfU1lNQk9MKHR0bV9ib192
bV9hY2Nlc3MpOwo+PiDCoCAraW50IHR0bV9ib192bV9tcHJvdGVjdChzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZwo+PiBzdGFydCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBlbmQsIHVuc2lnbmVkIGxvbmcgbmV3ZmxhZ3MpCj4+
ICt7Cj4+ICvCoMKgwqAgLyogRW5mb3JjZSBubyBDT1cgc2luY2Ugd291bGQgaGF2ZSByZWFsbHkg
c3RyYW5nZSBiZWhhdmlvciB3aXRoCj4+IGl0LiAqLwo+PiArwqDCoMKgIGlmIChpc19jb3dfbWFw
cGluZyhuZXdmbGFncykgJiYgKG5ld2ZsYWdzICYgVk1fV1JJVEUpKQo+PiArwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FSU5WQUw7Cj4+ICsKPj4gK8KgwqDCoCByZXR1cm4gMDsKPj4gK30KPj4gK0VY
UE9SVF9TWU1CT0wodHRtX2JvX3ZtX21wcm90ZWN0KTsKPj4gKwo+PiDCoCBzdGF0aWMgY29uc3Qg
c3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IHR0bV9ib192bV9vcHMgPSB7Cj4+IMKgwqDCoMKg
wqAgLmZhdWx0ID0gdHRtX2JvX3ZtX2ZhdWx0LAo+PiDCoMKgwqDCoMKgIC5vcGVuID0gdHRtX2Jv
X3ZtX29wZW4sCj4+IMKgwqDCoMKgwqAgLmNsb3NlID0gdHRtX2JvX3ZtX2Nsb3NlLAo+PiDCoMKg
wqDCoMKgIC5hY2Nlc3MgPSB0dG1fYm9fdm1fYWNjZXNzLAo+PiArwqDCoMKgIC5tcHJvdGVjdCA9
IHR0bV9ib192bV9tcHJvdGVjdCwKPj4gwqAgfTsKPj4gwqAgwqAgaW50IHR0bV9ib19tbWFwX29i
aihzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgc3RydWN0Cj4+IHR0bV9idWZmZXJfb2JqZWN0
ICpibykKPj4gwqAgewo+PiDCoMKgwqDCoMKgIC8qIEVuZm9yY2Ugbm8gQ09XIHNpbmNlIHdvdWxk
IGhhdmUgcmVhbGx5IHN0cmFuZ2UgYmVoYXZpb3Igd2l0aAo+PiBpdC4gKi8KPj4gLcKgwqDCoCBp
ZiAoaXNfY293X21hcHBpbmcodm1hLT52bV9mbGFncykpCj4+ICvCoMKgwqAgaWYgKGlzX2Nvd19t
YXBwaW5nKHZtYS0+dm1fZmxhZ3MpICYmICh2bWEtPnZtX2ZsYWdzICYgVk1fV1JJVEUpKQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+IMKgIMKgwqDCoMKgwqAgdHRtX2Jv
X2dldChibyk7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF90
dG1fZ2x1ZS5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfdHRtX2dsdWUuYwo+
PiBpbmRleCBlNmIxZjk4ZWM5OWYuLmU0YmY3ZGM5OTMyMCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfdHRtX2dsdWUuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vdm13Z2Z4L3Ztd2dmeF90dG1fZ2x1ZS5jCj4+IEBAIC02MSw2ICs2MSw3IEBAIGludCB2bXdf
bW1hcChzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0Cj4+IHZtX2FyZWFfc3RydWN0ICp2bWEpCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCAuZmF1bHQgPSB2bXdfYm9fdm1fZmF1bHQsCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCAub3BlbiA9IHR0bV9ib192bV9vcGVuLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
LmNsb3NlID0gdHRtX2JvX3ZtX2Nsb3NlLAo+PiArwqDCoMKgwqDCoMKgwqAgLm1wcm90ZWN0ID0g
dHRtX2JvX3ZtX21wcm90ZWN0LAo+PiDCoCAjaWZkZWYgQ09ORklHX1RSQU5TUEFSRU5UX0hVR0VQ
QUdFCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAuaHVnZV9mYXVsdCA9IHZtd19ib192bV9odWdlX2Zh
dWx0LAo+PiDCoCAjZW5kaWYKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9f
YXBpLmggYi9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5oCj4+IGluZGV4IGY2ODFiYmRiYzY5
OC4uNDBlYjk1ODc1MzU1IDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2Fw
aS5oCj4+ICsrKyBiL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fYXBpLmgKPj4gQEAgLTYwNSw2ICs2
MDUsMTAgQEAgdm9pZCB0dG1fYm9fdm1fY2xvc2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEp
Owo+PiDCoCDCoCBpbnQgdHRtX2JvX3ZtX2FjY2VzcyhzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZt
YSwgdW5zaWduZWQgbG9uZyBhZGRyLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZv
aWQgKmJ1ZiwgaW50IGxlbiwgaW50IHdyaXRlKTsKPj4gKwo+PiAraW50IHR0bV9ib192bV9tcHJv
dGVjdChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBzdGFydCwKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBlbmQsIHVuc2lnbmVk
IGxvbmcgbmV3ZmxhZ3MpOwo+PiArCj4+IMKgIGJvb2wgdHRtX2JvX2RlbGF5ZWRfZGVsZXRlKHN0
cnVjdCB0dG1fZGV2aWNlICpiZGV2LCBib29sIHJlbW92ZV9hbGwpOwo+PiDCoCDCoCB2bV9mYXVs
dF90IHR0bV9ib192bV9kdW1teV9wYWdlKHN0cnVjdCB2bV9mYXVsdCAqdm1mLCBwZ3Byb3RfdAo+
PiBwcm90KTsKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
