Return-Path: <SRS0=HO04=KR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCDAC04FF3
	for <amd-gfx@archiver.kernel.org>; Sat, 22 May 2021 02:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B25E613B6
	for <amd-gfx@archiver.kernel.org>; Sat, 22 May 2021 02:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B25E613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F23D6E8B8;
	Sat, 22 May 2021 02:57:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7AB26E8B8
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 May 2021 02:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEbKuNlAgyLoaLVFFf8UncG+9CqwDOJirVNSYkOOn0c1rO4gRalL3peWXZ7GNppItPB5jPK2+asAq0Opr5b1NFfEIxvCLtLD/NoTN/kBy9C0EmtcI9STlmwEFLh5fZS9WH0ZJJ2OrlBzMqOFY4jvT1ROzZdQDVkXX5MthqfDRHEDMuMgZOBuVdeFlyJ4xCvJfR6H/KVpcCWEln+UKvpQI6HtdxZOdS8eggl9lb1z6VuXsT/CKa3uVTotOn/TCKI0QrFv0O3juH5vQVvKm+nGU/hWewgImb8Weva4fufozT3V6kTTwtLjR/aLVqayG9ohkVXkOvaECXgiZAvYckGjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8mKZbxfhNTBU0NYEW5e76nIcJNgZbiVkWxQUVNMsMw=;
 b=XaRr2srXw1X9K1eu6T8KHFytfesg9klt6/ZYhAYgluRogz+FUtPlGuyAJ1WvObAm4XK4/u0SonC58JXt7y8N5IVWRDAcMwOdk/mOYnsm6QtNtlCgDrqHZQD3aKLaraNjSYyQ/KgKknT1cME1hUlmfuNwBtKQisaHIhoG/ZJpBQ/loJR/DHawa5ba/JO+O+499MfAMKinCWGELZF/lwdUMvFbCKa1yUvu9BprfUM86kkxHHknVtcWNQYTa4H0JlAikDr1csIM4hAkdGeWCv45HdxTGjU9KeXOi5+A2BPXi91OhEa+CkIKuojEzVmHLY9D+kYrZQNpQ8sYcV430uDPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8mKZbxfhNTBU0NYEW5e76nIcJNgZbiVkWxQUVNMsMw=;
 b=kCjwu+P3KgE7uYl9c9Fz0ksSu1TcaOrE8TsjxRFCygS62zPNgrlw9ooFs46hIqyzdXfp8dr+gIK8ibG36YrCWp/05syeRIZtqd9UQiyDOwxBlC1XXWKnkCBHKG+eTJdXaawnjBRuGYMB1ezy3TzOnJPkDAuYtGYTcoKz6zGaGv8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Sat, 22 May
 2021 02:57:05 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4150.026; Sat, 22 May 2021
 02:57:05 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix a BUG_ON due to resv trylock fails
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210522021114.4166-1-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f0221594-e9e1-5a84-2225-065a106b2995@amd.com>
Date: Fri, 21 May 2021 22:57:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210522021114.4166-1-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.56.206]
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.56.206) by
 YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Sat, 22 May 2021 02:57:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b50e99e0-1ebd-405f-fcfb-08d91ccd4824
X-MS-TrafficTypeDiagnostic: BN9PR12MB5177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB517717A072F7572019DCDCDE92289@BN9PR12MB5177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cr3QfL/kgRzhgw4HrCwFPNRnDAbSgpBYfZALBCcP9UjnziIhYQbXcl3G4S0ChEU5G9fmDwVetsIfxOT8okDb+lPz3EmXBj85TS1KiRBQYnV0LMQz4zNxAgU+MmrKhHtvb/N3ExE9Dmnhbz3c70mTGfX2C+0VtiXvfOjWbE+wZZjdcKmGS/tXtjQOW9GIqDVCoz2IVNVg+VEPF7m5EY7NQH5UjlSNP0VfsvpNuiaN+vXEjFi3Z50nWDQGiegT2I5x41Iq4qMehA9v00tOxWga/4ULMb3/oUvtSpBpMOdv5eMAx5P75NJmF9Owj8kCbuyJ3L+8DQVdoPID/2jCbU1EpL5m1vBQS98F8VwMLpvw7on4glEOn6ivYnSdzCzD5tsFt/RLBjs3otxTB0XywFeVyyCnq2A76frPIm3OqwCaSeZiqdHT/bIYiOMP0OM17mqfD3sQxtAFO4C8JEpq11V3KXAz73jXQSmsKaVntWbKF3qUbG4V7X9J0ZKBdQfOqPYnVzgicAIQxiMeFw9Ji6b3P99r33u8yTsxL2sGT4IMVapIWpBDwcG6wstWHirp30Z5OrweuuUiGNF42eLMqvWf2fT4H6lKLRRiWl9vHCwIR5D4rDcrlQrwnzCDxT9FYxV5QFWtMfZrbACmhj0jGXfZTd0/XJG1QxjIDkv2JeSDe9bGRptFyquX0s8HvUmX1TwE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8936002)(8676002)(2906002)(31696002)(26005)(83380400001)(186003)(66946007)(6486002)(66476007)(66556008)(16576012)(316002)(38100700002)(31686004)(16526019)(956004)(2616005)(86362001)(478600001)(36756003)(44832011)(5660300002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ejZma056WHJkcUp3VXNyaWp4dndrcUNrSnkxcEJjemYwT2h5UFZTYVhTYnM2?=
 =?utf-8?B?OXlCQWR4aXI0N2U5VTIrZ1oyczNVb2pJd1IrVDAvN2p5T1Q4ZW5FVG50eFVx?=
 =?utf-8?B?TDVodGpJUHBLQWRtVWpYbVBVdjl2dndwazd2djR0dG9RQkZwK3AwQ2RQb1ZB?=
 =?utf-8?B?V2VVTGNTM1NvZTF5Uys4THR2MllscmZUTnArQWhoRVl2alg1RmVOTDdnVkJK?=
 =?utf-8?B?NDlFdm9FWlFJdUQ1WUIyOGpKL29sMlFURWJhdUw1WUdtaEM5c2k2bTFXcVpW?=
 =?utf-8?B?dWZtc3lwNnBpVDMwZ1lZTkt6NTQ3YzZRU3M4RTEvcXFydlczQjhDazV0andI?=
 =?utf-8?B?M01ST2cxRXp5ZXZadWJIc3VzSG1UTmpoMU9IT2dCRk1ZYUZUZm16cEZJYnJ5?=
 =?utf-8?B?d0kvRjRid2lDY3paYitxTWpZbXp5UGRxOGJEVmNlektlcElXRUQwRTk1aGJz?=
 =?utf-8?B?UGp1a1pRRUdGK3lwTFFTTWREc2hpZ21xTmlvZVlVTnZGT0hwaXVDOEpkbzJo?=
 =?utf-8?B?dDBiMSswNUFmZEM5elRwQzRoM3FldWt1MDFUT1ZPZCtjN3dsbWhIMVR2TGZy?=
 =?utf-8?B?MnlEK2FZdzEvNmV6RmdGcWFkWHJab21jS1FLZE1lZ3I3NzBUODdPc2Q5bWNG?=
 =?utf-8?B?ckVDT29RckVRaXJwMlBsTHY2dS9JdnZvc1VLdUVWa3BmeG9QbkRQTGZuVU1s?=
 =?utf-8?B?N3ZKNVFua1VRV0hQUVJlRG1aaDlyVUFPZkpCVlhjRlI2S2U4OXo1Qmt5MDA4?=
 =?utf-8?B?bVRWUkxEYkZEbWlmSnFSTDdCOHpEQktSSml3TDdCQjVjUTJKdjZJNUh6RVJN?=
 =?utf-8?B?MDFMY3RzT29YbTFTWEsyMUcxZ2xGTWJaZ1RUZjFuWmVrNGdxUUU3OThwYXh5?=
 =?utf-8?B?QmNSNEhkakRQbEhJWjM1TzU3QkQ0RGVmd2xxQVZHSEUwK05zN1ZGN25sTHNP?=
 =?utf-8?B?TlloMC9FU0swbVJwTTJJVElYY3N4SHVLWFJLdkRTSFhSeGRPaW5PSWszeUFJ?=
 =?utf-8?B?MGcxaEZZTkM1RSs5Z1dxVTVBTk9QSTRySlFCWklJeUdVRmlrWEp1RDlLWHhU?=
 =?utf-8?B?aXZKMHVzSTdtbXNhOG9tczRFTUJGOGFOZWJ0ajlKK1k1ZWlsdEZkUGxJS1l6?=
 =?utf-8?B?TnFTQnJwTmZJclp4NmZkakplQzJiOEFQT001REpXZkl4N2NDelY2RDRYc0Vk?=
 =?utf-8?B?L0RXYlpSNFo0SEJJSDVpVnJsa29JdTFORG15R3ZVai96aUxlTm10TTBzUGk5?=
 =?utf-8?B?elpkYmd4RENnYUpJNWtGUk05MmVrd1FtOGRWQjBYUlVrYUNnWUZFOWRTZkRv?=
 =?utf-8?B?Z3FQWlNCeEdIN2MwUkVHSTY2UGl6bktkaHdPQkdUUU5walNVakg3aGtKaHlI?=
 =?utf-8?B?KzJRcE53OUFHeVYxcTExdXNFOXR0aWVlb2xwclkwdWlVcHAwQ0hrY2x3clRZ?=
 =?utf-8?B?dTRDSHh5OUNOOGo0ZjNyMlR4L0xmL2hUNVh3RU5yL0F4VmhtbmREQnVoSU5F?=
 =?utf-8?B?RmZmSHptM0VpdGJWeVplVVNZVjFrT2Z3bWRmbGsraUkycy80WjgxckcwZU1D?=
 =?utf-8?B?WU1QdmZqREtVMFJtVzcveHFZTUE4R1gvM2ovRmwwQTBTb2c1QytxbDhYZVVP?=
 =?utf-8?B?QURQR3NUNE13c3lTNElTZTFvVWpPbWFYZmQySzY0M2VoSnp5UHJPaWhSc0t1?=
 =?utf-8?B?SE1pOVVVZXcvZG51NTdyQ2pVRGo2eXR1TGhnVjNONXdPTTdaMGhNeU1makk0?=
 =?utf-8?Q?DCiHq80OPd/h5eDqj7fd8a3nLphp6VepwyGcBEs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50e99e0-1ebd-405f-fcfb-08d91ccd4824
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2021 02:57:05.5276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsLgv2b5Sk6l0phwTQ67YFv1Bd7gWZbRS9f4lOKRss/SDAF6HxJ9GbJEHgUUYQnn4cy42/WoeJK+kgPGVqZyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2hlbiB0aGUgQk8gZ2V0cyBpbmRpdmlkdWFsaXplZCwgdGhlcmUgaXMgYW4gYXNzdW1wdGlvbiB0
aGF0IG5vYm9keSBpcwphY2Nlc3NpbmcgaXQgYW55IG1vcmUuIFNlZSB0aGlzIGNvbW1lbnQgaW4g
dHRtX2JvX2luZGl2aWR1YWxpemVfcmVzdjoKCiAgICAgICAgICAgICAgICAvKiBUaGlzIHdvcmtz
IGJlY2F1c2UgdGhlIEJPIGlzIGFib3V0IHRvIGJlIGRlc3Ryb3llZCBhbmQgbm9ib2R5CiAgICAg
ICAgICAgICAgICAgKiByZWZlcmVuY2UgaXQgYW55IG1vcmUuIFRoZSBvbmx5IHRyaWNreSBjYXNl
IGlzIHRoZSB0cnlsb2NrIG9uCiAgICAgICAgICAgICAgICAgKiB0aGUgcmVzdiBvYmplY3Qgd2hp
bGUgaG9sZGluZyB0aGUgbHJ1X2xvY2suCiAgICAgICAgICAgICAgICAgKi8KClRoYXQgaXMgdmlv
bGF0ZWQgd2hlbiB0aGUgQk8gaXMgc3RpbGwgYmVpbmcgc3dhcHBlZCBvdXQgYXQgdGhpcyBzdGFn
ZS4KWW91IGNhbiBraW5kIG9mIHBhcGVyIHRoYXQgb3ZlciBieSB0YWtpbmcgdGhlIExSVSBsb2Nr
LiBCdXQgdGhlcmUgYXJlCnByb2JhYmx5IG90aGVyIHJhY2UgY29uZGl0aW9ucyBnb2luZyBvbiB3
aGVuIHRoZSByZXNlcnZhdGlvbiBnZXRzCnN3YXBwZWQgYnkgImluZGl2aWR1YWxpemUiIGR1cmlu
ZyBhbiBldmljdGlvbi4KCkkgdGhpbmsgdG8gYXZvaWQgYWxsIHRoYXQgVFRNIG5lZWRzIHRvIG1h
a2Ugc3VyZSB0aGF0IHRoZSBCTyBpcyBubwpsb25nZXIgb24gdGhlIExSVSBsaXN0IHdoZW4gaXQg
Z2V0cyBpbmRpdmlkdWFsaXplZC4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKQW0gMjAyMS0wNS0yMSB1
bSAxMDoxMSBwLm0uIHNjaHJpZWIgeGluaHVpIHBhbjoKPiBUaGUgcmVzZXJ2YXRpb24gb2JqZWN0
IG1pZ2h0IGJlIGxvY2tlZCBhZ2FpbiBieSBldmljdC9zd2FwIGFmdGVyCj4gaW5kaXZpZHVhbGl6
ZWQuIFRoZSByYWNlIGlzIGxpa2UgYmVsb3cuCj4gY3B1IDAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNwdSAxCj4gQk8gcmVsZWFzZQkJCQlCTyBldmljdCBvciBzd2FwCj4gCQkJ
CQlsb2NrIGxydV9sb2NrCj4gdHRtX2JvX2luZGl2aWR1YWxpemVfcmVzdiB7cmVzdiA9ICZfcmVz
dn0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHRtX2JvX2V2aWN0
X3N3YXBvdXRfYWxsb3dhYmxlCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZG1hX3Jlc3ZfdHJ5bG9jayhyZXN2KQo+IC0+cmVsZWFzZV9ub3RpZnkoKSB7
QlVHX09OKCF0cnlsb2NrKHJlc3YpKX0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKCF0dG1fYm9fZ2V0X3VubGVzc196ZXJvKSkKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFfcmVzdl91bmxvY2socmVzdikKPiAJ
CQkJCXVubG9jayBscnVfbG9jawo+IFRvIGZpeCBpdCBzaW1wbHksIGxldCdzIGFjcXVpcmUgbHJ1
X2xvY2sgYmVmb3JlIHJlc3YgdHJ5bG9jayB0byBhdm9pZAo+IHRoZSByYWNlIGFib3ZlLgo+Cj4g
U2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPgo+IC0tLQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCAyICsrCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPiBpbmRleCA5MjhlOGQ1N2NkMDgu
LjhmNmRhMDAzNGRiOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2dwdXZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2dwdXZtLmMKPiBAQCAtMzE4LDcgKzMxOCw5IEBAIGludCBhbWRncHVfYW1k
a2ZkX3JlbW92ZV9mZW5jZV9vbl9wdF9wZF9ib3Moc3RydWN0IGFtZGdwdV9ibyAqYm8pCj4gIAll
ZiA9IGNvbnRhaW5lcl9vZihkbWFfZmVuY2VfZ2V0KCZpbmZvLT5ldmljdGlvbl9mZW5jZS0+YmFz
ZSksCj4gIAkJCXN0cnVjdCBhbWRncHVfYW1ka2ZkX2ZlbmNlLCBiYXNlKTsKPiAgCj4gKwlzcGlu
X2xvY2soJmJvLT50Ym8uYmRldi0+bHJ1X2xvY2spOwo+ICAJQlVHX09OKCFkbWFfcmVzdl90cnls
b2NrKGJvLT50Ym8uYmFzZS5yZXN2KSk7Cj4gKwlzcGluX3VubG9jaygmYm8tPnRiby5iZGV2LT5s
cnVfbG9jayk7Cj4gIAlyZXQgPSBhbWRncHVfYW1ka2ZkX3JlbW92ZV9ldmljdGlvbl9mZW5jZShi
bywgZWYpOwo+ICAJZG1hX3Jlc3ZfdW5sb2NrKGJvLT50Ym8uYmFzZS5yZXN2KTsKPiAgCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
