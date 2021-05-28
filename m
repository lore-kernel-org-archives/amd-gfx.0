Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D570C2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 15:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6500610C7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 15:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6500610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A9E6EA7F;
	Fri, 28 May 2021 15:56:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C5466EA7F;
 Fri, 28 May 2021 15:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTQKtJx+hE3s8PoffR6aOenTZfCMXmEqwVM305HCdOGKb10QFRuoc+rFcg1b8MzCXv2ghTcBbCqS9Rcp7SiN8+FW6Ex0w8vEl8lsgWsEBGsA9QosHjpJw7820Lb4ScrwmANMFkukFtaUQ6xPi05418ot6q0tASMoIRgLe+VwcW2/OOGP93DseZz7L5Pbs6Dd+FvTaAF+sRMQ2NuDbdfz9Mu6GCR8xPdKit1LYYy00y5z6EoH0/jsPcVVdOqzLx24dWRpzF2FsFgVkx3rMCDtCw7pt6LmHAlyEtmnuJE02I5CioLjbgs7YUV2CVi82IteTw3m18+n9lkJmg59KmLHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqyRU5OiXOskszBAWVfOyrgawG0ZxQyQNEXgcKT+9hY=;
 b=CJCQDKHKif6c9E9XN8QGX76VupYYMRHcE3n6ryybev0HkVcM77CNfZ6wMCmvniiKSZtZtIdOEd0wP8Hv3DIvYt47dpX244jNd4CFwX53Q+z3hiuyXl9sFfz9dlKp/K6FyQ35vLXwXBp4Nhm+BhK5w6faQc6vu9NGesWTcdUTSDK5IyHyLgYXbX7L/84ogy5+zULo2vSI3mVdGoXiqhjsRkmuDY1MSX7BRXYbYp3vT8e4ZqYQHIOTvIOJNjYxhxQ05PNh1YGc12A8VKxPpmsuIGUaYLa35nd+0tjS44u2lAIq91c1RjDJpe6tAVjAD3biVmMdkTcHKe65ewplGRt1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqyRU5OiXOskszBAWVfOyrgawG0ZxQyQNEXgcKT+9hY=;
 b=RMgYqglXym5rlfmFi6J2BYStt/UuojfE7wFjacpripWnPCN//aoYwIP8KDnsKmjf44IZNGI3tYkQPkCGWzAvsrTKni/35yVMJWrTV8JuATljutDWJnUeuwNBrYFE9pZy5oopCR/Cc8vZBSxGSORXYPM1OFPPA7PXNYs66EeIWvg=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 15:56:38 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 15:56:38 +0000
Subject: Re: [RFC PATCH 0/5] Support DEVICE_GENERIC memory in migrate_vma_*
To: Jason Gunthorpe <jgg@nvidia.com>, Felix Kuehling <felix.kuehling@gmail.com>
References: <20210527230809.3701-1-Felix.Kuehling@amd.com>
 <20210528130816.GM1002214@nvidia.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f0bb142b-ab80-c16e-77dd-c7e1aa88c755@amd.com>
Date: Fri, 28 May 2021 11:56:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210528130816.GM1002214@nvidia.com>
Content-Language: en-US
X-Originating-IP: [142.186.56.206]
X-ClientProxiedBy: YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::45) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.56.206) by
 YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Fri, 28 May 2021 15:56:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0545e409-3265-4ddf-4ce4-08d921f12d36
X-MS-TrafficTypeDiagnostic: BN9PR12MB5050:
X-Microsoft-Antispam-PRVS: <BN9PR12MB505075BFB93EE449F91ACFF292229@BN9PR12MB5050.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbX5vvl80VSBGawIHTDyqrQrsPf5A0CSRZ0toqDG1tenNwN+d+THN9GSAPfm1H+ApmYtqf/HPa/s6nLVzS3/WKvbkOBrcr0zRVQTWrwvzGJyaU8C1KwxZDnZqlmUaaRs4XHHzATb3GYtsX8noJmkYu2+4bjNViroPTHeQVkinDDhwZMO7/uEqrTrw7UA6ECsvKrReh/xstLm/IaeI+udO5cfnMQorcJGeDwmYT3O7FC+42gqc7IiJbT1WZDkplj2p1JcO0io/nvq8+b8tJrXEgnW9IpvMwTuDB6PQFaEawXJjMwdruXEG/HKSZebax3PIqtJfi708fIHbzZRRS+x8nTVIXpMGURyB5SFnklKjkkk/ZYDqwOvScpbXoxibwYbIOaLu2vPp78j7+itnRU9SBFcsX6iF5313WuQ7r4N1gE/QyWx0kBw95Cwu0Lxj0rr1KnNx2zus5SniCAOOrNIibjibqonRepdDnT1rUsD/Yi8TKlPLk+Rvg0DfHU4SRy/E/T6WbQOXkIQvq3vXNmrFLnlzIRuiez5+z//2nmvrjWFTLnQ1jC9V7z7SPAu1/jJpHj+NNVQ4RUmIwW3wNIRM11gWKrlAgMcJ032+29tqZTh3GnT9p/EbVaxIWjadJjvJQ4G1f2wQ0qxui/teCHA+D2LPVHdX+27k/J2GoyIriG2PrZzJFERqayN31YRGJr1b4nwXniQr12p6WcoXPSkdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(5660300002)(66946007)(66556008)(86362001)(6486002)(66476007)(2906002)(31686004)(31696002)(83380400001)(36756003)(186003)(26005)(16526019)(956004)(2616005)(8936002)(478600001)(44832011)(4326008)(110136005)(316002)(16576012)(8676002)(38100700002)(41533002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M1V4U2RXWGVwRjcwRG9hdVJyTlNVTmxnaHdIQmxrbjBwUEFNMWtxZVY4elIy?=
 =?utf-8?B?R1BMQ1ZmQW9oY3BvekYwOVpZN3kxZWhPUnJrVGlhOE5xdDY3a0sramVaU0Ey?=
 =?utf-8?B?bGNUTGZ0bVVsdlMxWldLTEtET3p2NU9JdFJGeUFDdFpGdk5mVTNYR2hpTFJs?=
 =?utf-8?B?YzdHSVVkUG5ySGw0YmJHSDE4Y1BlbUtsUmF0aExBZHlycWI0Wm15Nk15cXVW?=
 =?utf-8?B?UUFLdnlIWGhrSlBvTWxTd0FQVUUvcVYrN2FLaVYzUm9JanhiRWNzMXg0cDJ3?=
 =?utf-8?B?aU9sS3pmSlVJbTBPMnpuSUNtM1g1aVlITW41anVKUHo4dG44SGM3YjN1MnFJ?=
 =?utf-8?B?QVp4aitXZU9BRDk3NDVkQ1AzSWZvY2x1ejRrZWxpVzRnR3BQY0puOVg3SGNP?=
 =?utf-8?B?cU1wVVJlQzFPQkVteW9DS1VPbVp0S1pWcWwvbTBXL3FIbHBHekpJeHJvNGJi?=
 =?utf-8?B?T0dEdXJFRXJPZlhiK3M0czFGbTZucS92MFB1WW43SDVZdEtUM3c1bHdxMHBC?=
 =?utf-8?B?eVdXa2kyeGNDblE3SXM3TEk1ei9TcUVzZnFmcnVWenFNV1FzNEJwL0V1Y2Fq?=
 =?utf-8?B?TDA5K09YWmdSZDVseXJIOXNCelBVYWd3Z25YcmtVa01DQjhlMGpIRkJUU1FC?=
 =?utf-8?B?RjgrdG5TWlROL2o4ZmJKYVY2UTd1aS90SlEvRDBPeFFrY1lERTB3NkVZbVhm?=
 =?utf-8?B?WnAwSXVzbm1vNWhnRm5ielVaNld3aUVBNTE5VXJhenFoczIwQ2lnV1ArTUxs?=
 =?utf-8?B?Uko3clFkMjBINmdlTUZOM3NlZWRZU3V2b2s0Rnk5MGZvNnpGeDhLMHlIK29T?=
 =?utf-8?B?c01aczVmQnlCYzJZUVRJL3lOQTA1SU9nbFhzRDBxMStDeDZUSTlwRGxIRGVl?=
 =?utf-8?B?MlZsR0xmSGxJZDRQVEF1WmQrSjdreGlZTStWa1ExNjYvczlnMkRrTFo2VW1L?=
 =?utf-8?B?K2dvdGkrcVd0TUdaUVoxWE1nOThOOTQ4Y2tZdVJMVlYyeVBNWlZQUE55SGpN?=
 =?utf-8?B?Zno5eDJGM1UvUzR3aUVEWEh4ZFJiVC9EYUFnM1RIWVhSdFhWWk82d1EvUDVq?=
 =?utf-8?B?d1p0RlVicWJWMGxScEZRTHlWcXR4ZDQwYXY5N1hVa1lSeVV4aDhUTW5CclE2?=
 =?utf-8?B?YXFJcUtCckxsdHdTUEhHaS9WTVplSi9zbnFQZ3V1bng4NEhOaUJsbWZhRndy?=
 =?utf-8?B?ZVR0MGlQNG1yaHZLSEs1TklLTlEvaWVOV2dpMXhPQUxpN3plSGI2ZjhMZ2Jn?=
 =?utf-8?B?Ti9Xb2FETDZxeHJrV3VHY2pJeVZuanI4NmJIQVRlcUxmVnYyOERvckNRNmRs?=
 =?utf-8?B?RFA0aUxOblZFSGh0Um9MVUQ2ZUp0d2hFQVZ6ODlid0NZT0c1c3BSYUpGbnZp?=
 =?utf-8?B?SnRzNUw1WlJONS93WFJmZnRqWEdVQ3N1MEhISlh1MmdVMUYwYVRWN0xWMU5J?=
 =?utf-8?B?ZDdlNVlrZTNha0VWNTFtWlNJSWZhR3FLcnlLbzcvQ0FGT0lxZUNMUlZRdDh2?=
 =?utf-8?B?d0s5UnVrMFZ4ZjE5UW1NTXlvdTcxS1NwRDZzblVrQWIrQzl2MDJVMWZ4YnQ3?=
 =?utf-8?B?TkRGSzhsWWZIdTVYYnBlOUExTzgySVM4NVRTZmdHTkVVamk3bmlMZERld3dM?=
 =?utf-8?B?STNMM3FlRmFBSTJiMUVHeXduS2Rxdk4vRnROYUVLZ212Q3BhbWx5VTcwY0Fh?=
 =?utf-8?B?SzhlSzlaRlRVa3hpVVRHQTJwTEdTUXRUWXV5QzRuQ1ZYclh2Mjc3ZUQ3K240?=
 =?utf-8?Q?Cf8vwe2Xj4A9k8jkUVwc13md0jg1uMZ4vzOsFmP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0545e409-3265-4ddf-4ce4-08d921f12d36
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 15:56:37.9880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmshI64ZgqflietPrkiYG1jNE1hqngoTlUwONzvE7EsJdoILa7wi+4ikTIWvHoqwfq9dlazvRTRl3MD2o46Blw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
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
Cc: amd-gfx@lists.freedesktop.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, akpm@linux-foundation.org, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNS0yOCB1bSA5OjA4IGEubS4gc2NocmllYiBKYXNvbiBHdW50aG9ycGU6Cj4gT24g
VGh1LCBNYXkgMjcsIDIwMjEgYXQgMDc6MDg6MDRQTSAtMDQwMCwgRmVsaXggS3VlaGxpbmcgd3Jv
dGU6Cj4+IE5vdyB3ZSdyZSB0cnlpbmcgdG8gbWlncmF0ZSBkYXRhIHRvIGFuZCBmcm9tIHRoYXQg
bWVtb3J5IHVzaW5nIHRoZQo+PiBtaWdyYXRlX3ZtYV8qIGhlbHBlcnMgc28gd2UgY2FuIHN1cHBv
cnQgcGFnZS1iYXNlZCBtaWdyYXRpb24gaW4gb3VyCj4+IHVuaWZpZWQgbWVtb3J5IGFsbG9jYXRp
b25zLCB3aGlsZSBhbHNvIHN1cHBvcnRpbmcgQ1BVIGFjY2VzcyB0byB0aG9zZQo+PiBwYWdlcy4K
PiBTbyB5b3UgaGF2ZSBjb21wbGV0ZWx5IGNvaGVyZW50IGFuZCBpbmRpc3Rpbmd1aXNoYWJsZSBH
UFUgYW5kIENQVQo+IG1lbW9yeSBhbmQgdGhlIG5lZWQgb2YgbWlncmF0aW9uIGlzIGJhc2ljYWx5
IGFsb3QgbGlrZSBOVU1BIHBvbGljeQo+IGNob2ljZSAtIGdldCBiZXR0ZXIgYWNjZXNzIGxvY2Fs
aXR5PwoKWWVzLiBGb3IgYSB0eXBpY2FsIEdQVSBjb21wdXRlIGFwcGxpY2F0aW9uIGl0IG1lYW5z
IHRoZSBHUFUgZ2V0cyB0aGUKYmVzdCBiYW5kd2lkdGgvbGF0ZW5jeSwgYW5kIHRoZSBDUFUgY2Fu
IGNvaGVyZW50bHkgYWNjZXNzIHRoZSByZXN1bHRzCndpdGhvdXQgcGFnZSBmYXVsdHMgYW5kIG1p
Z3JhdGlvbnMuIFRoYXQncyBlc3BlY2lhbGx5IHZhbHVhYmxlIGZvcgphcHBsaWNhdGlvbnMgd2l0
aCBwZXJzaXN0ZW50IGNvbXB1dGUga2VybmVscyB0aGF0IHdhbnQgdG8gZXhwbG9pdApjb25jdXJy
ZW5jeSBiZXR3ZWVuIENQVSBhbmQgR1BVLgoKCj4gIAo+PiBUaGlzIHBhdGNoIHNlcmllcyBtYWtl
cyBhIGZldyBjaGFuZ2VzIHRvIG1ha2UgTUVNT1JZX0RFVklDRV9HRU5FUklDIHBhZ2VzCj4+IGJl
aGF2ZSBjb3JyZWN0bHkgaW4gdGhlIG1pZ3JhdGVfdm1hXyogaGVscGVycy4gV2UgYXJlIGxvb2tp
bmcgZm9yIGZlZWRiYWNrCj4+IGFib3V0IHRoaXMgYXBwcm9hY2guIElmIHdlJ3JlIGNsb3NlLCB3
aGF0J3MgbmVlZGVkIHRvIG1ha2Ugb3VyIHBhdGNoZXMKPj4gYWNjZXB0YWJsZSB1cHN0cmVhbT8g
SWYgd2UncmUgbm90IGNsb3NlLCBhbnkgc3VnZ2VzdGlvbnMgaG93IGVsc2UgdG8KPj4gYWNoaWV2
ZSB3aGF0IHdlIGFyZSB0cnlpbmcgdG8gZG8gKGkuZS4gcGFnZSBtaWdyYXRpb24gYW5kIGNvaGVy
ZW50IENQVQo+PiBhY2Nlc3MgdG8gVlJBTSk/Cj4gSSdtIG5vdCBhbiBleHBlcnQgaW4gbWlncmF0
ZSwgYnV0IGl0IGRvZXNuJ3QgbG9vayBvdXRyYWdlb3VzLgo+Cj4gSGF2ZSB5b3UgdGhvdWdodCBh
Ym91dCBhbGxvd2luZyBNRU1PUllfREVWSUNFX0dFTkVSSUMgdG8gd29yayB3aXRoCj4gaG1tX3Jh
bmdlX2ZhdWx0KCkgc28geW91IGNhbiBoYXZlIG5pY2UgdW5pZm9ybSBSRE1BPwoKWWVzLiBUaGF0
J3Mgb3VyIHBsYW4gZm9yIFJETUEgdG8gdW5pZmllZCBtZW1vcnkgb24gdGhpcyBzeXN0ZW0uIE15
CnVuZGVyc3RhbmRpbmcgd2FzLCB0aGF0IERFVklDRV9HRU5FUklDIHBhZ2VzIHNob3VsZCBhbHJl
YWR5IHdvcmsgd2l0aApobW1fcmFuZ2VfZmF1bHQuIEJ1dCBtYXliZSBJJ20gbWlzc2luZyBzb21l
dGhpbmcuCgoKPgo+IFBlb3BsZSBoYXZlIHdhbnRlZCB0byBkbyB0aGF0IHdpdGggTUVNT1JZX0RF
VklDRV9QUklWQVRFIGJ1dCBub2JvZHkKPiBmaW5pc2hlZCB0aGUgd29yawoKWWVhaCwgZm9yIERF
VklDRV9QUklWQVRFIGl0IHNlZW1zIG1vcmUgdHJpY2t5IGJlY2F1c2UgdGhlIHBlZXIgZGV2aWNl
IGlzCm5vdCB0aGUgb3duZXIgb2YgdGhlIHBhZ2VzIGFuZCB3b3VsZCBuZWVkIGhlbHAgZnJvbSB0
aGUgYWN0dWFsIG93bmVyIHRvCmdldCBwcm9wZXIgRE1BIGFkZHJlc3Nlcy4KClJlZ2FyZHMsCsKg
IEZlbGl4CgoKPgo+IEphc29uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
