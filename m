Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01933606A31F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gkojRX4M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0D410E129;
	Tue, 27 Oct 2026 15:54:58 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010004.outbound.protection.outlook.com
 [52.101.193.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E05D10E129
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 15:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vugAY3Tmz60mYzfckLHuQ+4/SGbJX2zNvu6nq2wd4V2pS3GwQLRIMzhp12jIsabn+elVab0kSjHtycIsHQ5O+Bk9BF60IXDRwLaBO3JnQHVbClw/kmyqgxczoQR6bwNGW3L4/JAfMrui06BOSiAAawIn72FBGxnS/lptJdcQez65m/wMm6FmyfzgHkifec8o+acP6I8ra+lf3jOYqP1+sBn2QPMY8y0OUkdSPTwgxdLGAagla95H4+ejnTrlqcfFzODKl1NatwG6M4PMVPYdpyWNpF5o6xtAWtRo7cGxX1b/rsD7AoWWhFn8bgSAoNNwYyUIbZkvscEcMvmMpXvjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NcnRfLaiHwgRj3y1GkYUZPUjkH6+ar6A4tGjiOyeiU=;
 b=OM5LtiJ0VKASqbeF7lmAfw3g5x5yOnKsDSyTPHhBYGghDzo4As3KZgvJd8y9fR+lIFIcYEQ3X4a7iYcpOQOLFY+cETU8uoSxtsoabxwy/UP4mgH/P/ZK3GHXXfqs2Tv7l+QYYhQfLFuLQcKiRF8fwgiuywjFNaoN0X1dwjjjIiCnX7neROCVwD3eFfE6Jzd04pGOdNBDGjFtvzRQy3Hs8XSek/LZsoZ8x6E3s0oxFmce3OIDQv4hEjg7HeMZukYnMm6B/2jXBPmvUTFn3XjojDEoYlEmZyoijTHjgr55ux9JQkqIagjihodOf82y+3l19znrql3wTm9Qp3nC3+l3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NcnRfLaiHwgRj3y1GkYUZPUjkH6+ar6A4tGjiOyeiU=;
 b=gkojRX4MB4+gQkeB1jXbdN6sIhPSm18BRLWj9izQTkMBFsbckEoehFIZofCuLmb2zVyS1LD0z33fQbNFFRzSwtld1/FnIaFC+NePN3aQGihV1siv/XJBbLVIY0Sev64crayiACrVk15UqwwiUts390MKWD5xMivqtOeCJZcrM5Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by MW4PR12MB7360.namprd12.prod.outlook.com
 (2603:10b6:303:21a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:54:46 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:54:45 +0000
Message-ID: <eb350cb1-9d63-4075-91dd-f321ccc26199@amd.com>
Date: Tue, 27 Oct 2026 11:54:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 phasta@kernel.org, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Danilo Krummrich <dakr@kernel.org>
References: <20261022105443.60162-1-olivier.kaloudoff@gmail.com>
 <9c4f99bf-4bb4-4c31-9571-31f2aa57da38@amd.com>
 <d1db22be29151b65ac5054be1e80d36605ee732b.camel@mailbox.org>
 <38975a37-ca5a-40b4-ade5-d7ab861782e6@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <38975a37-ca5a-40b4-ade5-d7ab861782e6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0172.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::10) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: d72d9d0f-d3ac-4d94-3233-08df34429f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261026140227099003|11063799006|4143699003|56012099006|261026121527099003|261022105027099003|261021123027099003|261022075727099003|261021135927099003|261021121427099003|10067099003|20046099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: rB3Z1NAE7m3fvESTZqlDSN9rypwac9Qc3NzsozW/lPVjEi+eBJ3CPTXcqk8UFi49LEYziQ+mrcq83KXKExqNxA1Jh1EBAgiTZrAfF7n6JxkjafCfX9T0mxX8BT8kLlxWitlAgH7C01g4dSI5fjIsL4Qfzon73zxDj8V6Z76kVgUpRvEWkiNgu7fI+NUjWVlaA/10TV4Fbl1km3K3Gx2yh+ldreZrj9JKpxc5D+IBkeS6hmprwGZ+IuQlobU/ZRTlAKSxguufSTHIMJqsYlmPfW0dahQiizQKPXBPm6Vuhk/3kPzOynFuC6J68hEUd1ye0hNjC/YN9GxLzk6RAo+2qbnQfAt93k5txGUxyZb+QZKrgVSb+dywkbLS/AQeGs4NKesm/ISo4YcdsWnxjen1RKx/ytp8W30Emq010F2EVupMWvJmE2m6xfydEiGVlJGfHNGFotcm99NwEMbmEsBDQ/rr9EWlvNFZYVty76ZBcLFTF2FNt1OTCqxzlR/VqwymXb37GoiQpnzZN7yWiZdYMvi/bmJhk06tI9Xx51cAPqzVROrsY0XJCQKJVC0oowHvChYpZObG1MG2fl5vC92jSRS/L8PLb1XKK5ZxGQj8QUWx8mZN73PodfyBAjvBx2lTzQPu45arI2Tx/3RV7uzYvTWepcS9l4VH2wNOpYu56nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261026140227099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021135927099003)(261021121427099003)(10067099003)(20046099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3Y5NTAxZEFvODRValVZMEdIWDMrL0dIeEhNV3BsTFpnSXFSbnNzZlhZeUpo?=
 =?utf-8?B?a2ZITmp5eHBvZFphWStobnU4RUg1UzFGME5IU21RZVhFd1ltYjV6eDNSbTZN?=
 =?utf-8?B?Wjg4VU5tUmNjN3c2eGZwTDBWWnRZOUtVWHZkdXpZclVNUytsbEhNUVRQbHNn?=
 =?utf-8?B?MEF3RTJycUZmUUJIaHdaM1N1K3RBb21rRE9kb0tWU01zNlpUekxFOGp6Z3JG?=
 =?utf-8?B?ZVpZL1pPV2hiODVMRDIzbXQ3TG9sSUlJdDJReENvRFhlbGNyOXpqNUd3UTJO?=
 =?utf-8?B?MldmUmNneGs3S21sS0N4QXlBNW1Nd2JUeTZ3aHB4c0h1MmVLQ21ZWEZFeEtF?=
 =?utf-8?B?L0daUWVNa1VIb3g2RkNsUnU5Z3VWUG5lOHpVL3JBMjBHUTErQTZobDVaaWtu?=
 =?utf-8?B?cHVsRE93OS9iZkJnR1Zwb2RZbitQRDVza0xsbFhwTDh2ZUdNUHpCS0QvM1Bx?=
 =?utf-8?B?cnR1UmttTEVQMFpXQmxaK0RJelI0TnpDaVVpZ0ozSFdGSXNYV3pldHVVZzB3?=
 =?utf-8?B?NjJlRjFOT1E2WkFKOUVrSGxoTkhxWjdRZEQwTkJxVENxS1dRMDM4QldtcTly?=
 =?utf-8?B?aURlY3htazhaTTBjTjVSY2lkVXROQkZiM01HaHFvRGRhT2dRRWVVd2ZCTGNl?=
 =?utf-8?B?c3FSNzV2ZUFya1k1aTlLcURLaE5ucDBhMjdBM29qc1F0Z2tjN21RaVFobjdO?=
 =?utf-8?B?eW9Hcy9DMmFNMktIM2E4eCs4aFhhQ3hkaG5zbSs2dDdsUkc4eEhkbi9UTHc2?=
 =?utf-8?B?NkJSbnp5aFB3dTdLQ0hpbVh3Nm1tS2tMZmFJR1VsSkptZ3J6K3VjUHVPcDk0?=
 =?utf-8?B?Qk80UXFWUDh4dzFLdzlNNXNPczNGVWRHQmhIcDhyYjUwQ21QSjdCUFZVOVIv?=
 =?utf-8?B?UUtETDd4MzRqaWxRZFl2K2pPRVZpcElaMGF6MDlKbzhFdVRKa0JIem1xWUhk?=
 =?utf-8?B?aHJVcGV1dHl6MVBhZTFDdnVXK2wvRGxkMDRud1B5YTU5QnlaVllSdnY0bmxO?=
 =?utf-8?B?YXVJL3VqNjlRQ1Q2MFBCSHJyNXVKY0J3ZjJTM3JvWFBmZFpENXB5SDl3TW1O?=
 =?utf-8?B?dUZRN29XdkR5QnZ4bkdJcERIVHA5WFZYT0JsNTNETHh0K2Z6MmhueVMwYkJN?=
 =?utf-8?B?QkZSV2ZPRnd4WWFrYitKZVhoVWFIaXlBZFE0NWpYaUc2QkNRQk55YnBLMzlE?=
 =?utf-8?B?bmN2bS8vM09OOHZSazdVOW5HTEVJNE5WM0lyQS9aSVZRWEFScFNhczdBcTVo?=
 =?utf-8?B?YVBMcDNvRW9wc2RNL1VITEZVTFVQOXR1NGZMVjlCc2lWT3Y4UFd5bVF5OHFN?=
 =?utf-8?B?YllSK1FmU3FGd2tHUGVMSFFIdFRWTFNmY2NoWFZJaUNyNEpoRzVIVjB6aVNn?=
 =?utf-8?B?dHVNS0R2cnp5QitCVkMvZ1FNTXFZdGF1YldMalo1YkxjRXVzZ3JSL0FkVVZx?=
 =?utf-8?B?bGJmdVpuMFRUa3NYOWNpd1AyZC9lS3dTY2RPdG03TXVOWTdaZ0FPZ2FkMGZS?=
 =?utf-8?B?Ky83QTdXdkx3VnBzVGRYOWJkSnpuZlIxa2FWYVlOdStWUStDODZKVzRiWXQr?=
 =?utf-8?B?c05xWlNuUW5BZDNTa0FGY254RFRPS0tCTm12WGxtVEM4dU1QTktKOW9kVFpp?=
 =?utf-8?B?RXJWa3lkOUdLdWVWNVhZakdGYnE3OU1VQmlzZFhaTDQzQlVnZmFXSDlOWGF6?=
 =?utf-8?B?Z0pHbGlOSVpRUjBvNWhtT3lvNTFlcW10bFZmMEE1Rmd5OFVoTVViWDZtZHEy?=
 =?utf-8?B?UXM4bVVoUWJIN3FDMWRmbFRDNS9kMDFReVNVN3B4aExydXUvRVBTZUppTUp4?=
 =?utf-8?B?bnQ5cEEzTE52dTYxREMrS0VXVFoxMlJvNHREK05kM2ZoaHlYUjM4K0lodk1J?=
 =?utf-8?B?VC9DKzl0dmdUQVdjTXRLUFJCS0NnVkp2VlozZnljbGZhTHBMcXNCTlJnY2hC?=
 =?utf-8?B?cDhDdkkrekdjc29saGwwT0g0NFlxZXlVSTVpeXltSVdHL3F4N3JRTlNQWUFJ?=
 =?utf-8?B?TWNIYzA4YjBTaEFGZCt4TlNueHBOREl2Y1FFWXVVYklQR3UvVWhIOGlKTDlF?=
 =?utf-8?B?bWVOWXlVVGV6aFlvV3RTRjZRdVBRSnFkRDQrUWRQSEN5NG5EZjJkdkRTRzE0?=
 =?utf-8?B?MkFtdWl2KzJNdTZxNG04bG1kWjFRQWJpMUE2bTlmNjY4bi9SVjM0bStqWVZi?=
 =?utf-8?B?UGhCVnVkZHIyYjJCWmNhREROMVhnOFVaaW9RR2JpQVZaSS94SDVVeTdybUdM?=
 =?utf-8?B?UFNlR2lBUHM2TW91VURHN1NRWEY2UkdUSTlzRjEyNEhOWFpDUzA4QWt3MWlC?=
 =?utf-8?B?NXBHUWMxdWJvVG9kYWdFQnlTS3V1VCtGcFdaeVZ3QXB3VFZGcEwzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72d9d0f-d3ac-4d94-3233-08df34429f35
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:54:45.4680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNwMed7/Gc76PgVPWOEOmhh6VbNVp1G/0f+HcISSqBpVPrXDZJWyq/lGPzobeDpTe9rALLq+Z8s2sVcXG7x4Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 05:46, Christian König wrote:
> On 10/26/26 09:53, Philipp Stanner wrote:
>> On Mon, 2026-10-26 at 09:22 +0100, Christian König wrote:
>>> Hi Olivier,
>>>
>>> adding Philip and Danilo as DRM scheduler maintainers, just FYI on the technical background.
>>>
>>> On 10/22/26 12:54, Olivier Kaloudoff wrote:
>>>> Hi Christian,
>>>>
>>>>> No, what we need to avoid killing the entity while KFD is still
>>>>> using it!
>>>>>
>>>>> That is basically an use after free what you have here, only that
>>>>> the drm_sched can point that out with a warning instead of
>>>>> crashing immediately.
>>>> The exact "use" we hit is the dying process's own exit fault:
>>>> SIGBUS -> coredump -> get_dump_page -> do_swap_page ->
>>>> svm_migrate_to_ram() submits the migration job on the process's own
>>>> entity after drm_sched_entity_kill() already ran for it.
>>> Well, thanks for confirming my worst fear :) That is exactly what I
>>> expected and it is essentially unfixable.
>> What prevents you from having your own synchronisation primitive in the
>> struct where your drm_sched_entity lives in?
> The problem isn't really the synchronization nor the UAF of the scheduler entity.
>
> The fundamental problem is that SVM/HMM means that the local memory of the PCIe device (VRAM) is registered as "normal" system memory but in a way so that the kernel wouldn't use it by default for get free page.
>
> So you got struct pages for the device memory very similar to how for example DAX works. On GPU access the memory is then migrated to the device local memory and the system memory copy of the page is freed up.
>
> When you then now howplug the GPU and with it the local memory the data is from one second to next completely lost. If the data is an anonymous page the application will just crash, if the data is a memory mapped file it will eventually be tried to written back to storage. So you can even corrupt your file system with that leading to the system not booting anymore at all.

Migration of file-backed VMAs is not supported by HMM, as far as I know.


>
> I mean I have seen hot remove of DRAM modules like 30 years ago already, SPARC was really big with that. But in this case you got a red led where you ECC error was, pressed a button and halve a second later the OS removed all valuable data from this DRAM module and it was safe to remove.
>
> Hotplug on the other hand is a completely different beast because you don't get a pre-notification that you need to save your data. So hotplug is essentially incompatible with SVM/HMM.
>
> What Oliver tries to do here will never work even in theory.

What are we trying to achieve here? I think Olivier just wants the 
kernel to not hang or crash. It's obvious that any application using the 
unplugged GPU will die with a SIGBUS or some other catastrophic event. 
It doesn't really matter whether it used SVM or not. So if the result is 
that a migration of an anonymous page from unplugged VRAM back to system 
memory fails with a SIGBUS, that's not a big deal. That application was 
going to die anyway.

But we don't want the kernel to crash or panic if we can help it. And I 
don't see a fundamental reason why the kernel should crash.

Regards,
   Felix


>
> Regards,
> Christian.
