Return-Path: <SRS0=JwSO=MJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDDFC636C9
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Jul 2021 19:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F18610CD
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Jul 2021 19:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F18610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE186EAB8;
	Sat, 17 Jul 2021 19:54:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F4B6EAAC;
 Sat, 17 Jul 2021 19:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbrR4fruOy4X/FDhIKQENGvnRdXvVoPqY1HMBdH2RYCTbNTOQ8OeZ8aqJ0cnwfAJcaCtacZ/PEknUWrZeUjdKvO3gcRW/oOiirya49knyRZQDcFc5bpkqK9dZWTQVyE1TtU7ie79wXfANZM/fTP2CmSmd9npUp/a04SEH6NV0cXDpgvcDSDd8Tsyereq/Kis8iBCw1sNqFCyvh3MfdPAwq6uTZBTyI0SsyRKCoRbVqLjkyOvMWMbl+ZtpvvMOydCV7jrbmxWOmTAxrlTHpHSSW28xFEUBiavKTWNpa6pRmKZWMQDBHIVvCKgNO/RPejNia3uPsCDDuJf1ji5xURfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RB1vNKylzS+mtDGYh+fu9xIpasBlRWYcYOjK4+HlF8=;
 b=ZaFfFk7psUb7BwcXrXJJKF5ARGlE4XA72fLjXC9DHpJz6t4C5tS3Ennre5hk6szgj9bP/A1sliMg3sJAcu+VYd+2Hg2ay/AnRfKmClfLSiBG/vAP4JUPPZhZCJ9T+joIIThp2oRSB3cZwIK3jDUyiknZ+r/LvtGXhlUNJbUKp0zYLp15tb6XA1zEeZqSB3KHNTbroVVNSzVL8/4y+hGwCWuvGFRH92khjVoebQAY3rLjA2ABZdNASUBo89Ov3v05P7LGVMHco9Foa4xO78nqNkDPo5MvAo61CTEx2/dZseyl2W+iG4ZqlDT4NrphmlM3AVCON68MOZQXQftVzUEW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RB1vNKylzS+mtDGYh+fu9xIpasBlRWYcYOjK4+HlF8=;
 b=ceFI7tFafgeoLA4qb3BsPBT6C7N/eatBog3Wq2AZKy8tvvchcWhMlgmrUjXZJkoBM2JahjuHOjETcqiNpUOMPyldXskaooVLMpH+RWDme9bUFZ3rlSeb+GDjXz4ncKQZBoL32lc3y1EgfTOJn9SD2Oge55Xcm4iLnzi/EuYgbXw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (20.181.44.20) by
 SA0PR12MB4446.namprd12.prod.outlook.com (20.181.44.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Sat, 17 Jul 2021 19:54:21 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d0d3:a97e:6b7f:ab39]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d0d3:a97e:6b7f:ab39%7]) with mapi id 15.20.4331.029; Sat, 17 Jul 2021
 19:54:21 +0000
Subject: Re: [PATCH v3 0/8] Support DEVICE_GENERIC memory in migrate_vma_*
To: Felix Kuehling <felix.kuehling@amd.com>, "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20210617151705.15367-1-alex.sierra@amd.com>
 <YM9NXrGlhdp0qb7S@mit.edu> <905418d1-9099-0ea8-a6e6-84cc8ef3d0b0@amd.com>
 <YPGgvNxfOCx/Sp0g@mit.edu> <e9cc27d6-b0f2-8379-c276-0bbdae3ce4d7@amd.com>
From: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
Message-ID: <601418f5-c526-08e9-b071-4533a32ce25d@amd.com>
Date: Sat, 17 Jul 2021 14:54:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <e9cc27d6-b0f2-8379-c276-0bbdae3ce4d7@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SN6PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:805:de::43) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.9.47] (165.204.77.11) by
 SN6PR05CA0030.namprd05.prod.outlook.com (2603:10b6:805:de::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.8 via Frontend Transport; Sat, 17 Jul 2021 19:54:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 190f1b0f-1a23-430b-48b2-08d9495cab82
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44461F1B899EB45D1B05F70DFD109@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLdy0XyE4pjHkSinQs605y0idpwi4EPt53M8cLtIiJIWj//ZHRGXjjHPaE/YxlT5a53/b9gcnwrji1pyXsVrmhKk/cKZkSFqPgyswW9Y+GURCvoqdir7B2Fa67DkJBgD5g+3Qdyo5VkkP0jGSGyXLtitBlltqNVAC6jY1ISAECNlHkbFc4i2QZwZKUIz3dxdlpYYF0lw9GHT/tbyI5pfUK4RkK04M2XIkCM3D7wcEIg44qAGRi/R1fQLjguopIUjCsI44UbjKqrn8QLqja8ej+YnhLKRgorF4ooItiJZJVYZKp3txEgouIxF9MFdyyXya1oGYt1QBJOuo6diRdXV0WtqWp+fKLEPKR1kkfubQsU36UT6PMwZ7qD3qtbyTqfJLwY0mS2eZprgcXVB03U5G4q8WBO20K1Bj+ADaN3NLTb+10Ep5H6sZl0g8khHo65hiqY5muWJoTWPOIxLkQ4mUd2JNEomHIJ6gU5owHGtiJ3/9eX/+AXimt3+xhAFO5APc/nzrYomW9YS8RgfZ+0vgYZIQMIFTVTQiPFFNdrFMl+x4nuR6vL7Pe1GkkcNEsFlFt+PeRpaSoqU3PTQ7ZFbyiwJ3YQPXOOPMn0OPpdIoOemMnYYj89vc27/ott2OWqglHd0wwaTonNWde8W86Iu4zg4ONT0xcJXr50PtsvYIja285QumbEUWjaj/9bgP8YI/thpBxzrS6xZgvpHENQQE3/35J8nFRIl0n4pgo716J0L2j65WI1Y36jEMpu9PjJzN5qjTugvayrQL1o19j/mKl5hEpLm6EgGykC8FwOdv+zqadzR30zgUKiKsL1z8xTgKWyNHpZz46JJCGumc49eEf5WlPpUMHIFl/0oYceiAN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(38350700002)(38100700002)(53546011)(110136005)(7416002)(2906002)(52116002)(83380400001)(186003)(6666004)(6486002)(26005)(2616005)(966005)(956004)(31696002)(36756003)(5660300002)(86362001)(16576012)(66946007)(66556008)(66476007)(316002)(31686004)(8936002)(478600001)(8676002)(4326008)(41533002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDR1TDFLNkdxSVh2TDBCK3R5NWRNWW4xbjFXZ0J1SGtwL0VOdStBMXhhb09w?=
 =?utf-8?B?RUMrTHpONC93enlzMkh1QWZGb1F0aGVSTE1zait0SmxYK0F6eDBMeG1WZ28r?=
 =?utf-8?B?WlU3YWk0OFlhRVpWcHBWZ2tmbGpYOUtqSEVxRGNPN0w3clVTWXZHZ0hzTkQ4?=
 =?utf-8?B?WE4yK1I0WWdXUGU4cmFSZkpPUEZFSmltRFFFN1loRlFLWlBBeDRyb296alIv?=
 =?utf-8?B?NnN6emhpemxONWFub0NycE81VFg4bndxN1Y0WVROT2NEaHNnRVROdHpOckg1?=
 =?utf-8?B?V0c3WEJtcGtoNitXd0d0VENFOEdyMnRkTlI3Znc5VWlacHNzTXE3SzF5L01a?=
 =?utf-8?B?M1JlWEJFUGdpMGVUck4zSEgwMTFlSTNpZXdrTFpyM1JabUVoWkRodkdmMEtZ?=
 =?utf-8?B?UlZ1Skp4Ry83VngwUlVQamZZYnhKdzhXSWhINXFRVEtzYTBrOFlMd0FkNm5t?=
 =?utf-8?B?TDRySmljV1I5WXh5MzdpMGhlTStKNk1mV3E0a0tRMjNFaUdQczFYaVBSN2NI?=
 =?utf-8?B?cndFM1A0NWUyYUpiZHhFeU1PcVM3UEw0UHQvNjBUOWJEVUpTN3dYNnhQay9N?=
 =?utf-8?B?VGtpMXJFaE5Vci9RbU0yNWtJQmJwejRNanFsNWthRlVZQjVGVGFxY0owbUhQ?=
 =?utf-8?B?MThLcDlhZUEvSDhwSzBKM3cyeHBrcHI3MjE1MjBhdnV4OVlDenlWVFJTMDRD?=
 =?utf-8?B?VUZHL1hyUExWZURhYlFVUk83RVlhZ29sVzVKZjhhRUwwUXl6bHg4bWt1VU8z?=
 =?utf-8?B?UmM3NUtMQUlqcDF3ZUlNWlUybStiMVl5c2ZNc2hMeWp5eGw5SlgyWnBMWllC?=
 =?utf-8?B?bFAyNitWN0tGbFpRcGdtU3RJOExEMHlycGh4STFVOHptM0NndzlyQkRYaFlQ?=
 =?utf-8?B?Z29YVkhPUlJIQm5kNVBTQ0xBaWtNT3ZxVSsyU0RoMTdiL21LMkRDOW54akdo?=
 =?utf-8?B?OWhWUlBWbkYxdkxjSHk0NlAyMVFJd3hTMlU0ZW5NMWd4Y3ppSEdoTGFEK0Jo?=
 =?utf-8?B?aXJTeDJvUzk5LzdxUksySGI2Q3c1UDk4bHVaQmErZVNxd3JvUHFRMFVST21l?=
 =?utf-8?B?K0RXK0RuSS9EV05RQVhOb3NGbTB0ck5jSnE0c1hnUlV4aGFGRTV4WmxXcW5K?=
 =?utf-8?B?clEwZi9aR2tENFV4OVNqQ3Q4WVNXOGFWRmRZRTVjOWo3WEp5UDJlbXJkYXJX?=
 =?utf-8?B?RDNPa1ltenpZV2FRbmpPVWpGcnhJV0FUT3V5dGlibUVaWEtoS2lZemNVSTNy?=
 =?utf-8?B?L04zRjB4Nk9DcEZBY0R4R214ZkI1K3g4cUp3Zk50dlNHUW9ML05iMmlLMENE?=
 =?utf-8?B?N3JYOWhhUmR6WEdERVdZckFneE0zdlJ2ZEt3MUtoQVZFL09QSjFZM3RPN0Jk?=
 =?utf-8?B?ZmxYd01mcGR6MVNURXB3a2lucmJrclF3RjhDeVIrN1oyYnVtRFlDQkVIaExZ?=
 =?utf-8?B?VVlCWXNubE83TGVLaFk0aktHOCtQaFM2bkxFM2FUcjlKQVFNYmRsTFhBTUFo?=
 =?utf-8?B?ZlVVdTZNMzFqZU9Ya0w0VTh6T1UxVDVON29US0lxZHpWQk5HNDk4ZExHWEtK?=
 =?utf-8?B?S25OMzFQd3F0ZEZiN2NnZjN4ZndPSkVxcWhVOUUvd2NyRkFFS21LZk5XK1NL?=
 =?utf-8?B?QWg0ZDc3Q1Faa25yc2ZMWlBkL05Cbk9mWG9NczBCYkpHYVpBRWxBeXp4YmhC?=
 =?utf-8?B?bnRUbDlZSmtGaCtoNlRTTjM5ZDRldjNubVQ2UFpsREUvVVBIZGlZb010U0Fh?=
 =?utf-8?Q?2eJf6J4Lfe15rkyFp/8eGGTmAK6iOEUZB4XtdiD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190f1b0f-1a23-430b-48b2-08d9495cab82
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 19:54:21.5903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72VxJbcyvqC9DWQNTwAK4OYOYSuvrtnohC/gn3vUnRMxB7HSj7TP4OxVFBKIfq5cJOEzZnsT1wRuEnpaI/na8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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
Cc: rcampbell@nvidia.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, jgg@nvidia.com, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDcvMTYvMjAyMSA1OjE0IFBNLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPiBBbSAyMDIxLTA3
LTE2IHVtIDExOjA3IGEubS4gc2NocmllYiBUaGVvZG9yZSBZLiBUcydvOgo+PiBPbiBXZWQsIEp1
biAyMywgMjAyMSBhdCAwNTo0OTo1NVBNIC0wNDAwLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPj4+
IEkgY2FuIHRoaW5rIG9mIHR3byB3YXlzIHRvIHRlc3QgdGhlIGNoYW5nZXMgZm9yIE1FTU9SWV9E
RVZJQ0VfR0VORVJJQyBpbgo+Pj4gdGhpcyBwYXRjaCBzZXJpZXMgaW4gYSB3YXkgdGhhdCBpcyBy
ZXByb2R1Y2libGUgd2l0aG91dCBzcGVjaWFsIGhhcmR3YXJlIGFuZAo+Pj4gZmlybXdhcmU6Cj4+
Pgo+Pj4gRm9yIHRoZSByZWZlcmVuY2UgY291bnRpbmcgY2hhbmdlcyB3ZSBjb3VsZCB1c2UgdGhl
IGRheCBkcml2ZXIgd2l0aCBobWVtIGFuZAo+Pj4gdXNlIGVmaV9mYWtlX21lbSBvbiB0aGUga2Vy
bmVsIGNvbW1hbmQgbGluZSB0byBjcmVhdGUgc29tZSBERVZJQ0VfR0VORVJJQwo+Pj4gcGFnZXMu
IEknbSBvcGVuIHRvIHN1Z2dlc3Rpb25zIGZvciBnb29kIHVzZXIgbW9kZSB0ZXN0cyB0byBleGVy
Y2lzZSBkYXgKPj4+IGZ1bmN0aW9uYWxpdHkgb24gdGhpcyB0eXBlIG9mIG1lbW9yeS4KPj4gU29y
cnkgZm9yIHRoZSB0aHJlYWQgbmVjcm9tYW5jeSwgYnV0IG5vdyB0aGF0IHRoZSBtZXJnZSB3aW5k
b3cgaXMKPj4gcGFzdC4uLi4KPiBObyB3b3JyaWVzLiBBbGVqYW5kcm8gc2hvdWxkIGhhdmUgYSBu
ZXcgdmVyc2lvbiBvZiB0aGlzIHNlcmllcyBpbiBhIGZldwo+IGRheXMsIHdpdGggdXBkYXRlcyB0
byBobW1fdGVzdCBhbmQgc29tZSBmaXhlcy4KClY0IHBhdGNoIHNlcmllcyBoYXZlIGJlZW4gc2Vu
dCBmb3IgcmV2aWV3LgpodHRwczovL21hcmMuaW5mby8/bD1kcmktZGV2ZWwmbT0xNjI2NTQ5NzE2
MTg5MTEmdz0yCgpSZWdhcmRzLApBbGV4IFNpZXJyYQoKPgo+Cj4+IFRvZGF5IEkgdGVzdCBleHQ0
J3MgZGF4IHN1cHBvcnQsIHdpdGhvdXQgaGF2aW5nIGFueSAkJCQgREFYIGhhcmR3YXJlLAo+PiBi
eSB1c2luZyB0aGUga2VybmVsIGNvbW1hbmQgbGluZSAibWVtbWFwPTRHITlHOm1lbW1hcD05RyEx
NEciIHdoaWNoCj4+IHJlc2VydmVzIG1lbW9yeSBzbyB0aGF0IGNyZWF0ZXMgdHdvIHBtZW0gZGV2
aWNlIGFuZCB0aGVuIEkgcnVuCj4+IHhmc3Rlc3RzIHdpdGggREFYIGVuYWJsZWQgdXNpbmcgcWVt
dSBvciB1c2luZyBhIEdvb2dsZSBDb21wdXRlIEVuZ2luZQo+PiBWTSwgdXNpbmcgVEVTVF9ERVY9
L2Rldi9wbWVtMCBhbmQgU0NSQVRDSF9ERVY9L2Rldi9wbWVtMS4KPj4KPj4gSWYgeW91IGNhbiBn
aXZlIG1lIGEgcmVjaXBlIGZvciB3aGF0IGtlcm5lbCBjb25maWdzIEkgc2hvdWxkIGVuYWJsZSwK
Pj4gYW5kIHdoYXQgbWFnaWMga2VybmVsIGNvbW1hbmQgbGluZSBhcmd1bWVudHMgdG8gdXNlLCB0
aGVuIEknZCBiZSBhYmxlCj4+IHRvIHRlc3QgeW91ciBwYXRjaCBzZXQgd2l0aCBleHQ0Lgo+IFRo
YXQgd291bGQgYmUgZ3JlYXQhCj4KPiBSZWdhcmRpbmcga2VybmVsIGNvbmZpZyBvcHRpb25zLCBp
dCBzaG91bGQgYmUgdGhlIHNhbWUgYXMgd2hhdCB5b3UncmUKPiB1c2luZyBmb3IgREFYIHRlc3Rp
bmcgdG9kYXkuIFdlJ3JlIG5vdCBjaGFuZ2luZyBvciBhZGRpbmcgYW55IEtjb25maWcKPiBvcHRp
b25zLiBCdXQgbGV0IG1lIHRha2UgYSBzdGFiOgo+Cj4gWk9ORV9ERVZJQ0UKPiBITU1fTUlSUk9S
Cj4gTU1VX05PVElGSUVSCj4gREVWSUNFX1BSSVZBVEUgKG1heWJlIG5vdCBuZWVkZWQgZm9yIHlv
dXIgdGVzdCkKPiBGU19EQVgKPgo+IEknbSBub3Qgc3VyZSB3aGF0IHlvdSdyZSBsb29raW5nIGZv
ciBpbiB0ZXJtcyBvZiBrZXJuZWwgY29tbWFuZCBsaW5lLAo+IG90aGVyIHRoYW4gdGhlIG1lbW1h
cCBvcHRpb25zIHlvdSBhbHJlYWR5IGZvdW5kLiBUaGVyZSBhcmUgc29tZSBtb3JlCj4gb3B0aW9u
cyB0byBydW4gaG1tX3Rlc3Qgd2l0aCBmYWtlIFNQTSAoREVWSUNFX0dFTkVSSUMpIG1lbW9yeSwg
YnV0IHdlJ3JlCj4gYWxyZWFkeSBydW5uaW5nIHRoYXQgb3Vyc2VsdmVzLiBUaGF0IHdpbGwgYWxz
byBiZSBpbiB0aGUgbmV4dCByZXZpc2lvbgo+IG9mIHRoaXMgcGF0Y2ggc2VyaWVzLgoKSW4gb3Jk
ZXIgdG8gcnVuIGhtbSB0ZXN0IHdpdGggZ2VuZXJpYyBkZXZpY2UgdHlwZSBlbmFibGVkLCBzZXQg
dGhlIApmb2xsb3dpbmc6CgprZXJuZWwgY29uZmlnOgpFRklfRkFLRV9NRU1NQVAKUlVOVElNRV9U
RVNUSU5HX01FTlUKVEVTVF9ITU09bQoKS2VybmVsIHBhcmFtZXRlcnMgdG8gZmFrZSBTUCBtZW1v
cnkuIFRoZSBhZGRyZXNzZXMgc2V0IGhlcmUgYXJlIGJhc2VkIG9uIApteSBzeXN0ZW0ncyB1c2Fi
bGUgbWVtb3J5IGVudW1lcmF0ZWQgYnkgQklPUy1lODIwIGF0IGJvb3QuIFRoZSB0ZXN0IApyZXF1
aXJlcyB0d28gU1AgZGV2aWNlcyBvZiBhdCBsZWFzdCAyNTZNQi4KZWZpX2Zha2VfbWVtPTFHQDB4
MTAwMDAwMDAwOjB4NDAwMDAsMUdAMHgxNDAwMDAwMDA6MHg0MDAwMAoKVG8gcnVuIHRoZSBobW1f
dGVzdCBpbiBnZW5lcmljIGRldmljZSB0eXBlIHBhc3MgdGhlIFNQIGFkZHJlc3NlcyB0byB0aGUg
CnNoIHNjcmlwdC4Kc3VkbyAuL3Rlc3RfaG1tLnNoIHNtb2tlIDB4MTAwMDAwMDAwIDB4MTQwMDAw
MDAwCgo+Cj4gSWYgeW91IGNhbiBydW4geW91ciB4ZnN0ZXN0cyB3aXRoIERBWCBvbiB0b3Agb2Yg
dGhpcyBwYXRjaCBzZXJpZXMsIHRoYXQKPiB3b3VsZCBiZSB2ZXJ5IGhlbHBmdWwuIFRoYXQncyB0
byBtYWtlIHN1cmUgdGhlIFpPTkVfREVWSUNFIHBhZ2UgcmVmY291bnQKPiBjaGFuZ2VzIGRvbid0
IGJyZWFrIERBWC4KPgo+IFJlZ2FyZHMsCj4gIMKgIEZlbGl4Cj4KPgo+PiBDaGVlcnMsCj4+Cj4+
IAkJCQkJCS0gVGVkCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
