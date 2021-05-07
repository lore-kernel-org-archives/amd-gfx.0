Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FCDC433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 16:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5DA6144F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 16:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5DA6144F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2AEE6E05F;
	Fri,  7 May 2021 16:32:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F846E05F;
 Fri,  7 May 2021 16:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8swBTOZkOgs4pdAnv/J7YJ+KYypzxe1JaCop4VThfyQMGj++suBau95DPj5TgE1dnasAVr9CUFhtQIVcSMbYwNz5pAhZ0+TjAk5WPLjKjkZ97NlQCXtBg//ZvNp7cpxOGKpIafQfFPQoa6XBN2Iqqjdvy+4CL0EeVtY3Z0ZZyTfKa2fUJbdry8SME3BDT2EhLBDIQEWW4G8V8m3q4Pc7rllsBkPpus1AcgZv3AgIun7Y0/f1H1lTzVrKhxKzFiYVzQqtlAZzaFSuU8m7lCPbB2e1Wg+oeDkI7TYR3hnkQP5NHNMheHlq9Bai3VYxVNA2ywkpxXzIpFSG13t15wpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lhd9+YVt3lHzeYkr8J8DUKMZBzOG98ntShXTc4HZS28=;
 b=P3XvNy+BTXU3nsYav1UD8IAoZFa60KJAmLp806smaD8HfowIeH9il7pby8VbAiv+XLLLVVinIHPJLCbwz/XmEgP0t4nwWf4cKsh5eh5vDz4Aq4c5YDjd+AsU//aokGx78OayVfZ5jfT8pmA2qpw1Vx9OP7dO7CF1XA6zjdqYgIkrTWCg2LXWkUrWUVzvnWz6ZXfx8JnES1ClP+ZNKLvZt2rPDN760XYfO0a9YoCMQ70x78CdecKSXdvKMXy3cwAfn5YvSFeVrmeR4UG6ejYLTIm1ysrRzCjot6F2JwnYQI3cxlRwCeP2Cz1bFA9eEDkmoQKagBBj3Mz8am+b3OrbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lhd9+YVt3lHzeYkr8J8DUKMZBzOG98ntShXTc4HZS28=;
 b=aqIICd218fkpiCVRjOnp1sCm9NW+vAERyd83lgpCk3UcmwB54d/hDGZv+lnov1JKrODRlJGr8pfHjgIqEd5k78dQKS3fLNTAzYZCkBG5uM69yLTbAHR7kZ3Qy2DjZt5KKd/Ue5xcwgQC7uW2uDymvDVO2XATPwTc1+UMN+/vxL0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 7 May
 2021 16:32:24 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4108.030; Fri, 7 May 2021
 16:32:24 +0000
Subject: Re: [PATCH v5 15/27] drm/scheduler: Fix hang when sched_entity
 released
To: Daniel Vetter <daniel@ffwll.ch>
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-16-andrey.grodzovsky@amd.com>
 <a8314d77-578f-e0df-5c49-77d5f10c76c7@amd.com>
 <9cb771f2-d52f-f14e-f3d4-b9488b353ae3@amd.com>
 <0c598888-d7d4-451a-3d4a-01c46ddda397@gmail.com>
 <a704880d-8e27-3cca-f42b-1320d39ac503@amd.com>
 <YJVq4x4d81rY2GHB@phenom.ffwll.local>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <e2bd01fc-1d1e-bc76-2187-72bb602fbac7@amd.com>
Date: Fri, 7 May 2021 12:32:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YJVq4x4d81rY2GHB@phenom.ffwll.local>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:3bd1:bdb6:f650:9629]
X-ClientProxiedBy: YT2PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::23) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:3bd1:bdb6:f650:9629]
 (2607:fea8:3edf:49b0:3bd1:bdb6:f650:9629) by
 YT2PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Fri, 7 May 2021 16:32:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 899cc3ef-c219-41f0-2bde-08d91175b208
X-MS-TrafficTypeDiagnostic: SA0PR12MB4576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4576F6518DADD4CF2CDDF1C9EA579@SA0PR12MB4576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sX4nxPTXPUeL1ETG6vi87JvkRLpqSU7slmQhtl4GXgzbS0b1OMfIC3+rnVR2yjQucHEjlyQrswqsYnWyYOdjUXFrhUtAD+AwbIQ2wyYvTAWgkL4svcT3LGxh0JFACgp72q1VK20Sox9XxjJH5Fe/I77UzuH4yve8WtpubKmFmCcVuYD3xTkCM66FNTEzhEJNPqU/NN3uxEiXWbKF2ljpBxXDzjttS+FQuAwCRuJEjKnW8VrgD834iU6cVafy1RKwMkJJQmb6ZiaH/KL+uSocgEKK3IzAZ+vTZIfxkj/GD3+D4bbh+y5MnueWyJqkzDycff9l2IoxR03YRUXo9UUVtKNaxgGxv414wT1FJ/S04nZbear3sZciE3MzqJ7qIMEgL4bh+rh+SeXcHrB241oKCo+SIWB51+9bD/c/0AgiyRDWY/vGTa1BnE9vLLe4/c8mvrJE0aFEdc/kfDeF61WZtGMUbdD/XV9RkGxNC7YjyCqwtefA48sCBPM2UPsWAOIMfEJ0ysP7/bO88UJYtjl8wSxt5X5Eatcuy4Tf79JnhPcbkdymqSOexHcaK1ArHot1aRtybVPM1hINg5+Ss84jh4rTStZ4DyLV2LJM4NM7WndXbHJwyGAxxn4A3G4ASbmLkHQxB0mI7oq6EPMaw/lj6SqOalWkPzqLNNPFm24wQK5rRLF6RT3kNhrHBqjWgTGr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(36756003)(54906003)(2616005)(66556008)(66476007)(2906002)(66946007)(44832011)(52116002)(6486002)(6916009)(4326008)(53546011)(31696002)(478600001)(8676002)(86362001)(66574015)(5660300002)(31686004)(83380400001)(16526019)(316002)(8936002)(38100700002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VWNXZGo1UTFsL1o4ZXlkdzloL05pVUlZc3dLOXhaUWE5Z0J4Vk1BSExldGR0?=
 =?utf-8?B?c3hLK28zQTJXTGVPS3dCTW8xN2xZV3lZTVA4Tm10RkIvdUZmT2U5eS94eGR6?=
 =?utf-8?B?bThIcHBFb0ZiK1hFU1hiajVyWUJXR1Z2QVQ4RklHektyMm03Qlgya2Vacjlm?=
 =?utf-8?B?U29JcWFnZDhBL0VFYUxpYWNxYkIrSEFhQ0NUb1lwbVlWNURhTG1kNzJwWjdm?=
 =?utf-8?B?OWJwT2hkSmVxVDJiRnVGbHNremRrN21ZUjBEcnVKMVVCampkdE45ZExTVHRl?=
 =?utf-8?B?VkxYVGN5WlY2Qk1BYmNnRWVRREpjMyt6NUdlWDFoMkdFbzc5RlZxTW0zREpM?=
 =?utf-8?B?a0FQekVmNmp6M0NmRlJtZnJpMi84Z011eFBmTTN3SVVMYnI4U0tiaUlxQ0t3?=
 =?utf-8?B?Yng4L2ZvTVdBWGxNVmZ1RnI1ZTBKQmQ1SUo2ZEthTUZDeEwyaFcrMGk0NUwv?=
 =?utf-8?B?R0JVdzNNcFc2bW4wM3ZlS1c3YlVPYlY4S3JFYnhUWmtlQy9POFZ4eWw3bVc2?=
 =?utf-8?B?RTl0OTJHTzAwUUpiR01QaU5VaWd1RkFwczZ6VGphSC9xdlMyQjZmYnVvdWx1?=
 =?utf-8?B?elVENkQxLyt4WEVjbi9iNFdrUlkxL0JtT0pFcFNPWktiTlM4Q0l6Y3pBVy8x?=
 =?utf-8?B?dEZPM0lwMnA1UmhXVEtFNlY2N1NBaC9xYUszTCtSNCtVNXJjL0U1bjh5Skgv?=
 =?utf-8?B?Y3p0YUNIc2JTMCtXWGE5S1BYT2I0STFMRGRHM1dVaXF2dHFYSDQ0V05aMVBE?=
 =?utf-8?B?VGZPWFg3RzRNL3lHZW03KzQ2OVNINzNxUjdsOW1QM0g5WVJNaU9IQ3FHM0JL?=
 =?utf-8?B?c0ZBNnJiNjY4bXRoZm5LUjZGSC9HVmg2RFNoRkZOdVVONzJtekpNUFhxeWtw?=
 =?utf-8?B?WFg0M3NYSHFnbTlHZUZwNFFsTFdFdS94QkpCY3QzUDJNOHl6djg5TkFqWjdT?=
 =?utf-8?B?QnB0aGRwWEFKTitPL0x0TDQzU0ZvdFBkbm9KZEx2S0cxZWdTbXQ0aUd5RURi?=
 =?utf-8?B?VXlxMnMwcFpPVkdnWlZlR3ZLMXRTeGdqeHlDaU9yWHArUzlxM1I0TU1ET0hh?=
 =?utf-8?B?ZXlTOUdya01uM2U5emcrbzNBcVZqbTl2NUJ2bktPV05PaVJqS3VmTmhqSUZv?=
 =?utf-8?B?Z0ZRa0tQT3k5a1J3YnRHOXN0d0dmT1NGV2xLblpyZWp1eXd1N2t0VW5aUTNv?=
 =?utf-8?B?Y0RHUHMycWh5dHZCYnNWcENKRGR5cklnc3JlelBTeUR1RlFGMzdCS0VtMytQ?=
 =?utf-8?B?RGJjV3NSYWN0S2NRcVdGZUZ1dTdvR21GS3VtbHdNTEZFWStleURhejJMMUxF?=
 =?utf-8?B?MG1mT3RGcVVsSFJ4ZXFBNHRMMmwxWXhJWklOeEFhVjdWQUFqSXJNODExMGpr?=
 =?utf-8?B?ZTRDZjYwRVVRcnc4bmxETnk3aCtPZWVNN29Bc0xZK0o5TFoxMG00dmFYSEs4?=
 =?utf-8?B?SEZVYmQyVm1panlLSmR6WGh1bUpPLzYxRVF4N0RoVTlrZFNKRUpldWNLZlJW?=
 =?utf-8?B?eWtHUGZYVkVkOTVRVDQ0OFhTUTg5eUh1L2F4NGZINldxaDFyUEY1MDA4bUxs?=
 =?utf-8?B?NFkwdFlJdDFRaFVDT3dnMlo1dms4blJISWgxLythaUQ2VzRISkR3V1VpVWVu?=
 =?utf-8?B?eDhYUmVZRTJVTC9wbVVWbUV0ZHVrdEcrMmZJM1h6OVh2Q1dZQnd0V2VMYTJT?=
 =?utf-8?B?VVNlRUVTeCt5dmIwZjRSWkVvSk5rQ3dyRm15N2hEdWtUUHNNT0RuOWxiOWpF?=
 =?utf-8?B?dGxXNURGNmt2bFU0SGI2b3hoUTQ2bmtsREpIZmRWT1VLQTlNRHQ0OVVpWVY0?=
 =?utf-8?B?V2pkajBjQk5OditlaGM2RzJrNTNkRmxsWXViaXZBMmxEVUFKS3U2aHFLay9y?=
 =?utf-8?Q?VUdfV6pffYi1C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899cc3ef-c219-41f0-2bde-08d91175b208
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 16:32:24.7280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yh/476s+avwmswW8Ols239rkQR6V7d1swrTeyz4FB8g/ROYGxAv0/+Tf5K5UjI6uAtp+LOg66+KhrU4v0yM+tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
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
Cc: gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch, Felix.Kuehling@amd.com,
 linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org, ppaalanen@gmail.com,
 helgaas@kernel.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander.Deucher@amd.com, Harry.Wentland@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA1LTA3IDEyOjI5IHAubS4sIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4gT24gRnJp
LCBBcHIgMzAsIDIwMjEgYXQgMTI6MTA6NTdQTSAtMDQwMCwgQW5kcmV5IEdyb2R6b3Zza3kgd3Jv
dGU6Cj4+Cj4+Cj4+IE9uIDIwMjEtMDQtMzAgMjo0NyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdy
b3RlOgo+Pj4KPj4+Cj4+PiBBbSAyOS4wNC4yMSB1bSAxOTowNiBzY2hyaWViIEFuZHJleSBHcm9k
em92c2t5Ogo+Pj4+Cj4+Pj4KPj4+PiBPbiAyMDIxLTA0LTI5IDM6MTggYS5tLiwgQ2hyaXN0aWFu
IEvDtm5pZyB3cm90ZToKPj4+Pj4gSSBuZWVkIHRvIHRha2UgYW5vdGhlciBsb29rIGF0IHRoaXMg
cGFydCB3aGVuIEkgZG9uJ3QgaGF2ZSBhCj4+Pj4+IG1hc3NpdmUgaGVhZGFjaGUgYW55IG1vcmUu
Cj4+Pj4+Cj4+Pj4+IE1heWJlIHNwbGl0IHRoZSBwYXRjaCBzZXQgdXAgaW50byBkaWZmZXJlbnQg
cGFydHMsIHNvbWV0aGluZyBsaWtlOgo+Pj4+PiAxLiBBZGRpbmcgZ2VuZXJhbCBpbmZyYXN0cnVj
dHVyZS4KPj4+Pj4gMi4gTWFraW5nIHN1cmUgYWxsIG1lbW9yeSBpcyB1bnBvbGF0ZWQuCj4+Pj4+
IDMuIEpvYiBhbmQgZmVuY2UgaGFuZGxpbmcKPj4+Pgo+Pj4+IEkgYW0gbm90IHN1cmUgeW91IG1l
YW4gdGhpcyBwYXRjaCBoZXJlLCBtYXliZSBhbm90aGVyIG9uZSA/Cj4+Pj4gQWxzbyBub3RlIHlv
dSBhbHJlYWR5IFJCZWQgaXQuCj4+Pgo+Pj4gTm8gd2hhdCBJIG1lYW50IHdhcyB0byBzZW5kIG91
dCB0aGUgcGF0Y2hlcyBiZWZvcmUgdGhpcyBvbmUgYXMgIzEgYW5kICMyLgo+Pj4KPj4+IFRoYXQg
aXMgdGhlIGVhc2llciBzdHVmZiB3aGljaCBjYW4gZWFzaWx5IGdvIGludG8gdGhlIGRybS1taXNj
LW5leHQgb3IKPj4+IGFtZC1zdGFnaW5nLWRybS1uZXh0IGJyYW5jaC4KPj4+Cj4+PiBUaGUgc2No
ZWR1bGVyIHN0dWZmIGNlcnRhaW5seSBuZWVkIHRvIGdvIGludG8gZHJtLW1pc2MtbmV4dC4KPj4+
Cj4+PiBDaHJpc3RpYW4uCj4+Cj4+IEdvdCB5b3UuIEkgYW0gZmluZSB3aXRoIGl0LiBXaGF0IHdl
IGhhdmUgaGVyZSBpcyBhIHdvcmtpbmcgaG90LXVucGx1Zwo+PiBjb2RlIGJ1dCwgb25lIHdpdGgg
cG90ZW50aWFsIHVzZSBhZnRlciBmcmVlIE1NSU8gcmFuZ2VzIGZycG9tIHRoZSB6b21iaWUKPj4g
ZGV2aWNlLiBUaGUgZm9sbG93dXAgcGF0Y2hlcyBhZnRlciB0aGlzIHBhdGNoIGFyZSBhbGwgYWJv
dXQgcHJldmVudGluZwo+PiB0aGlzIGFuZCBzbyB0aGUgcGF0Y2gtc2V0IHVwIHVudGlsIHRoaXMg
cGF0Y2ggaW5jbHVkaW5nLCBpcyBmdW5jdGlvbmFsCj4+IG9uIGl0J3Mgb3duLiBXaGlsZSBpdCdz
IG5lY2Vzc2FyeSB0byBzb2x2ZSB0aGUgYWJvdmUgaXNzdWUsIGl0J3MgaGFzCj4+IGNvbXBsaWNh
dGlvbnMgYXMgY2FuIGJlIHNlZW4gZnJvbSB0aGUgZGlzY3Vzc2lvbiB3aXRoIERhbmllbCBvbiBs
YXRlcgo+PiBwYXRjaCBpbiB0aGlzIHNlcmllcy4gU3RpbGwsIGluIG15IG9waW5pb24gaXQncyBi
ZXR0ZXIgdG8gcm9sbG91dCBzb21lCj4+IGluaXRpYWwgc3VwcG9ydCB0byBob3QtdW5wbHVnIHdp
dGhvdXQgdXNlIGFmdGVyIGZyZWUgcHJvdGVjdGlvbiB0aGVuCj4+IGhhdmluZyBubyBzdXBwb3J0
IGZvciBob3QtdW5wbHVnIGF0IGFsbC4gSXQgd2lsbCBhbHNvIG1ha2UgdGhlIG1lcmdlCj4+IHdv
cmsgZWFzaWVyIGFzIEkgbmVlZCB0byBjb25zdGFudGx5IHJlYmFzZSB0aGUgcGF0Y2hlcyBvbiB0
b3AgbGF0ZXN0Cj4+IGtlcm5lbCBhbmQgc29sdmUgbmV3IHJlZ3Jlc3Npb25zLgo+Pgo+PiBEYW5p
ZWwgLSBnaXZlbiB0aGUgYXJndW1lbnRzIGFib3ZlIGNhbiB5b3Ugc291bmQgeW91ciBvcGluaW9u
IG9uIHRoaXMKPj4gYXBwcm9hY2ggPwo+IAo+IEknbSBhbGwgZm9yIGluY3JlbWVudGFsbHkgbGFu
ZGluZyB0aGlzLCBiZWNhdXNlIGl0J3MgcmVhbGx5IGhhcmQgYW5kCj4gdHJpY2t5LiBXZSBtaWdo
dCBuZWVkIHRvIGdvIGJhY2sgdG8gc29tZSBvZiB0aGUgZGVjaXNpb25zLCBvciBjbGFyaWZ5Cj4g
dGhpbmdzIG1vcmUsIG9yIG1vcmUgaGVhZGFjaGVzIGFuZCBwb25kZXJpbmcgaG93IHRvIGZpeCBh
bGwgdGhlIHBhcnRzCj4gdGhhdCB3b3JrcyBiZXN0IHRvIG1ha2Ugc3VyZSB0aGVyZSdzIG5vIG5h
c3R5IHJhY2VzIHJpZ2h0IGFjcm9zcyBob3R1bnBsdWcKPiBpZiB5b3UncmUgdW5sdWNreSBlbm91
Z2guCj4gCj4gQnV0IHllYWggYmV0dGVyIGFpbSBmb3Igc29tZXRoaW5nIGFuZCB0aGVuIHJlYWRq
dXN0IHRoYW4gYmlrZXNoZWQgZm9yZXZlcgo+IG91dCBvZiB0cmVlLgo+IAo+IENoZWVycywgRGFu
aWVsCgpUaGFua3MsIEkgd2lsbCBzZW5kIG91dCBWNiBsaW1pdGVkIGluIHNjb3BlIHVwIHRvIGhl
cmUgYW5kIGZpeGluZwphbnkgcmVsZXZhbnQgY29tbWVudHMuCgpBbmRyZXkKCj4gCj4+Cj4+IEFu
ZHJleQo+Pj4KPj4+Pgo+Pj4+IEFuZHJleQo+Pj4+Cj4+Pj4+Cj4+Pj4+IENocmlzdGlhbi4KPj4+
Pj4KPj4+Pj4gQW0gMjguMDQuMjEgdW0gMTc6MTEgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToK
Pj4+Pj4+IFByb2JsZW06IElmIHNjaGVkdWxlciBpcyBhbHJlYWR5IHN0b3BwZWQgYnkgdGhlIHRp
bWUgc2NoZWRfZW50aXR5Cj4+Pj4+PiBpcyByZWxlYXNlZCBhbmQgZW50aXR5J3Mgam9iX3F1ZXVl
IG5vdCBlbXB0eSBJIGVuY291bnRyZWQKPj4+Pj4+IGEgaGFuZyBpbiBkcm1fc2NoZWRfZW50aXR5
X2ZsdXNoLiBUaGlzIGlzIGJlY2F1c2UKPj4+Pj4+IGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZQo+
Pj4+Pj4gbmV2ZXIgYmVjb21lcyBmYWxzZS4KPj4+Pj4+Cj4+Pj4+PiBGaXg6IEluIGRybV9zY2hl
ZF9maW5pIGRldGFjaCBhbGwgc2NoZWRfZW50aXRpZXMgZnJvbSB0aGUKPj4+Pj4+IHNjaGVkdWxl
cidzIHJ1biBxdWV1ZXMuIFRoaXMgd2lsbCBzYXRpc2Z5IGRybV9zY2hlZF9lbnRpdHlfaXNfaWRs
ZS4KPj4+Pj4+IEFsc28gd2FrZXVwIGFsbCB0aG9zZSBwcm9jZXNzZXMgc3R1Y2sgaW4gc2NoZWRf
ZW50aXR5IGZsdXNoaW5nCj4+Pj4+PiBhcyB0aGUgc2NoZWR1bGVyIG1haW4gdGhyZWFkIHdoaWNo
IHdha2VzIHRoZW0gdXAgaXMgc3RvcHBlZCBieSBub3cuCj4+Pj4+Pgo+Pj4+Pj4gdjI6Cj4+Pj4+
PiBSZXZlcnNlIG9yZGVyIG9mIGRybV9zY2hlZF9ycV9yZW1vdmVfZW50aXR5IGFuZCBtYXJraW5n
Cj4+Pj4+PiBzX2VudGl0eSBhcyBzdG9wcGVkIHRvIHByZXZlbnQgcmVpbnNlcmlvbiBiYWNrIHRv
IHJxIGR1ZQo+Pj4+Pj4gdG8gcmFjZS4KPj4+Pj4+Cj4+Pj4+PiB2MzoKPj4+Pj4+IERyb3AgZHJt
X3NjaGVkX3JxX3JlbW92ZV9lbnRpdHksIG9ubHkgbW9kaWZ5IGVudGl0eS0+c3RvcHBlZAo+Pj4+
Pj4gYW5kIGNoZWNrIGZvciBpdCBpbiBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUKPj4+Pj4+Cj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KPj4+Pj4+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+ICDCoCBkcml2ZXJzL2dwdS9kcm0vc2No
ZWR1bGVyL3NjaGVkX2VudGl0eS5jIHzCoCAzICsrLQo+Pj4+Pj4gIMKgIGRyaXZlcnMvZ3B1L2Ry
bS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jwqDCoCB8IDI0Cj4+Pj4+PiArKysrKysrKysrKysrKysr
KysrKysrKysKPj4+Pj4+ICDCoCAyIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVy
L3NjaGVkX2VudGl0eS5jCj4+Pj4+PiBpbmRleCBmMDc5MGU5NDcxZDEuLmNiNThmNjkyZGFkOSAx
MDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5
LmMKPj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMK
Pj4+Pj4+IEBAIC0xMTYsNyArMTE2LDggQEAgc3RhdGljIGJvb2wKPj4+Pj4+IGRybV9zY2hlZF9l
bnRpdHlfaXNfaWRsZShzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5KQo+Pj4+Pj4gIMKg
wqDCoMKgwqAgcm1iKCk7IC8qIGZvciBsaXN0X2VtcHR5IHRvIHdvcmsgd2l0aG91dCBsb2NrICov
Cj4+Pj4+PiAgwqDCoMKgwqDCoCBpZiAobGlzdF9lbXB0eSgmZW50aXR5LT5saXN0KSB8fAo+Pj4+
Pj4gLcKgwqDCoMKgwqDCoMKgIHNwc2NfcXVldWVfY291bnQoJmVudGl0eS0+am9iX3F1ZXVlKSA9
PSAwKQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNwc2NfcXVldWVfY291bnQoJmVudGl0eS0+am9i
X3F1ZXVlKSA9PSAwIHx8Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgZW50aXR5LT5zdG9wcGVkKQo+
Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsKPj4+Pj4+ICDCoMKgwqDCoMKg
IHJldHVybiBmYWxzZTsKPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1
bGVyL3NjaGVkX21haW4uYwo+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVk
X21haW4uYwo+Pj4+Pj4gaW5kZXggOTA4YjBiNTYwMzJkLi5iYTA4NzM1NGQwYTggMTAwNjQ0Cj4+
Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+Pj4+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPj4+Pj4+IEBAIC04
OTcsOSArODk3LDMzIEBAIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2luaXQpOwo+Pj4+Pj4gIMKg
wqAgKi8KPj4+Pj4+ICDCoCB2b2lkIGRybV9zY2hlZF9maW5pKHN0cnVjdCBkcm1fZ3B1X3NjaGVk
dWxlciAqc2NoZWQpCj4+Pj4+PiAgwqAgewo+Pj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgZHJtX3NjaGVk
X2VudGl0eSAqc19lbnRpdHk7Cj4+Pj4+PiArwqDCoMKgIGludCBpOwo+Pj4+Pj4gKwo+Pj4+Pj4g
IMKgwqDCoMKgwqAgaWYgKHNjaGVkLT50aHJlYWQpCj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKg
IGt0aHJlYWRfc3RvcChzY2hlZC0+dGhyZWFkKTsKPj4+Pj4+ICvCoMKgwqAgZm9yIChpID0gRFJN
X1NDSEVEX1BSSU9SSVRZX0NPVU5UIC0gMTsgaSA+PQo+Pj4+Pj4gRFJNX1NDSEVEX1BSSU9SSVRZ
X01JTjsgaS0tKSB7Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9ycSAq
cnEgPSAmc2NoZWQtPnNjaGVkX3JxW2ldOwo+Pj4+Pj4gKwo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGlmICghcnEpCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4+Pj4+
ICsKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX2xvY2soJnJxLT5sb2NrKTsKPj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KHNfZW50aXR5LCAmcnEtPmVudGl0aWVz
LCBsaXN0KQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBQcmV2ZW50cyByZWluc2VydGlvbiBhbmQgbWFya3Mgam9iX3F1
ZXVlIGFzIGlkbGUsCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogaXQgd2lsbCBy
ZW1vdmVkIGZyb20gcnEgaW4gZHJtX3NjaGVkX2VudGl0eV9maW5pCj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICogZXZlbnR1YWxseQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqLwo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc19lbnRpdHktPnN0b3BwZWQg
PSB0cnVlOwo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZycS0+bG9jayk7Cj4+
Pj4+PiArCj4+Pj4+PiArwqDCoMKgIH0KPj4+Pj4+ICsKPj4+Pj4+ICvCoMKgwqAgLyogV2FrZXVw
IGV2ZXJ5b25lIHN0dWNrIGluIGRybV9zY2hlZF9lbnRpdHlfZmx1c2ggZm9yCj4+Pj4+PiB0aGlz
IHNjaGVkdWxlciAqLwo+Pj4+Pj4gK8KgwqDCoCB3YWtlX3VwX2FsbCgmc2NoZWQtPmpvYl9zY2hl
ZHVsZWQpOwo+Pj4+Pj4gKwo+Pj4+Pj4gIMKgwqDCoMKgwqAgLyogQ29uZmlybSBubyB3b3JrIGxl
ZnQgYmVoaW5kIGFjY2Vzc2luZyBkZXZpY2Ugc3RydWN0dXJlcyAqLwo+Pj4+Pj4gIMKgwqDCoMKg
wqAgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZzY2hlZC0+d29ya190ZHIpOwo+Pj4+Pgo+Pj4K
PiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
