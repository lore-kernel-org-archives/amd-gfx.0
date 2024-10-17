Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52ACD37487
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7188810E32E;
	Thu, 17 Oct 2024 13:16:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UuFwJjXv";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E07BE10E32E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:16:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJde60wXrWeWBssbc/8gjd5MKqtlAmfDc9HU0XtglfmQLNXwiWN1Y25/wBx9KnoSeXgicY11+PVcSRvu4rvMMynEEBp9JjyYqGoaRvLbJ4cuviiJh3APYdU0i3TQOtGk2q10iliEfHgC7yekc9hpVqXTQQnfDM6zBRJ3GRm4U6Crv0CyCno++tqklS152DLpvLwF05bS1MvHxvuDp839s25p+8fLJBRwEVY1s0qB4LuhmtTkXBopASn4Myf2nldcJ9WdrgcDIiGtAUilorS9XES+509y+66fl3X5BN8cuilMiD63uMm+M2pXOkiycUGkoHaBSY0zsMlsjiVNIyRoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThjUy+u4yICHpEwUxA2qgWBbG67qrzcMJZygEbSRpQ0=;
 b=m0sct5KnN+RQqtQ9pcu2SD5k0OVOB5aPGx5lejESkL4siU+qAx5wzYC77vgKau5PDCrFByGX4pa+K43JAKDThdPk0q1qz/TDN6IzjkACteg0m2M++UOGACfe3H9qtmhszYhklCSClTQWews8glg/tb2kdfQoL5ZxmK2JaUzZUy+tazyOOMySoFhLbgZVcIPOFFVqKLYkyIU6XFQgmdKfmTdANbRwQfkPhSO+xgC7OJrRgBjQoLBkhlt1v8PLwNi1xo+DpfqzCUAM/wwMdBPjHv3eA9A736y3FQrciXXacZtSYRmj9YeI8ZGTNstT7ctR9PVuvJClcgFAcwr1mND8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThjUy+u4yICHpEwUxA2qgWBbG67qrzcMJZygEbSRpQ0=;
 b=UuFwJjXvJooohNZTy/PALBMjqycAvWp37JCJr5YulCYkx1H+OWY+rM2koXnqTXkKcHdh71v+tT3RQHGkBXt/81+1f8zOhYeD2bEi7f6G/S74tahniwZ3kVZ0OXWLVcvIFQiABcLdY+7++zMYMT6YqYJqsa4sISBBIy2B/a0guKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 13:16:43 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 13:16:43 +0000
Message-ID: <3f175af5-ab8f-40f0-ae1b-4d3f7ad04e17@amd.com>
Date: Thu, 17 Oct 2024 18:46:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Save VCN shared memory with init reset
To: "Liu, Leo" <Leo.Liu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "Jiang, Sonny" <Sonny.Jiang@amd.com>, "Zhou, Hao (Claire)" <Hao.Zhou@amd.com>
References: <20241015062316.3050046-1-lijo.lazar@amd.com>
 <7cd47976-10c9-41d1-9e48-8b47617b3d48@amd.com>
 <DM8PR12MB53993F24544631CE138C41EFE5462@DM8PR12MB5399.namprd12.prod.outlook.com>
 <8ede8dfc-1718-416e-96c5-e6033c5bfb87@amd.com>
 <CO6PR12MB5394D8B004517BD13D463C6BE5472@CO6PR12MB5394.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CO6PR12MB5394D8B004517BD13D463C6BE5472@CO6PR12MB5394.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001AD.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: d7579b9f-0528-4878-eacf-08dceeadf1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MG5BMmIyMi9WT2hQRFk2VE10WlJEbkdvTTFKelJYVkhmVFhtZUwxSTloMjBt?=
 =?utf-8?B?QU5CeEJQNDgrU21Pa3pIbkZnYmJNTXBFMVM5dXhjSW42QmFpdy9nQVJtVHlG?=
 =?utf-8?B?M1FwdW5rM3dVN1V0SEhDaExNc2FWbncwbk9lQW5BZnlQODFNeXA1ZEp6b0p0?=
 =?utf-8?B?QWJVS01jeGZIOFRiMitWVW9nMUpndWpOc0NabVYrRHBNakhNMm9Bd25CS3pi?=
 =?utf-8?B?V3VqL29xUC9tcjZLYWh2dEwvZUVtWDZYQmtXT29aUXRKTVdkSkVkWUExZ2VH?=
 =?utf-8?B?WE9kVzhWb25TemdmUS83Mi9KQWlBVFhDOWxYQ1pqVkVNU1ZJMXdOOHlVS2V4?=
 =?utf-8?B?NS92cjdlWXpLakdtK2JvemEzdnR1WHdQTWJxdkNma2lSMnZucjhmb3djWkNP?=
 =?utf-8?B?ZTQrZzdqNXgwRVd1QzVHSXR0WkpJNXVJT3IyNGJDVGtpTEhEV0k4NEhoTWhs?=
 =?utf-8?B?elBDNnM1Qyt6WGxkYXhrUDlOYW56Rkt2MEdNK2tVd3JDeThOYm56RTg5VGZC?=
 =?utf-8?B?a1BZeUdhRjBUajZSY1N3UGlod1VmdHdmNlY5aHh6RHNDYlpxcFQybDE2ak9y?=
 =?utf-8?B?a0ZaZldXMitORFlXQW01QmtBTFpYZGtpY2pQMGtvWkdDSGlSOGgraWoxS3lo?=
 =?utf-8?B?VGdUNUJUaFJPbHpaamNxSGJ3SzhqaU5uVngzcXFMRC9YVTdSV1V5ZEFNZnRl?=
 =?utf-8?B?UUl0N0tpNlZFRU43WE84NUVLcG5SRC9BTWFTdVZPUjd4S29oMUUyMmpERU9F?=
 =?utf-8?B?ZEpOTE5EODdKd0p6cm1QQTFPWFM3OG1LbUdEdmgza3BEWE1pL0c2QXVQeC9a?=
 =?utf-8?B?UzBFcDBacWxJNC8vbGdjNCswOVYyTHEydDlNWnp4OG1pTHdIbnpzUzVwYUtm?=
 =?utf-8?B?MHRrd3Zkem1jSWdqUzRGbmlyWXR5Wm56bzRJUFJ5RXRaZHhqVjJaenRQRkNj?=
 =?utf-8?B?UGphenhZUDF6WnRnbXN4OENpcmMzOGZXYTFNREVxZFpsdFJFRDVSeFpYS0tL?=
 =?utf-8?B?UVlUS21PMnhCZUxTRjlQQUlkVVN6YjMwbUNsb1RLcDNMK3ptVzkyeTJjZVcz?=
 =?utf-8?B?UkdLbVY0QnFSWkczRkRRdW9SeWxlZis3KzJOM0piN3BiZU1oT0lMOTFlT08w?=
 =?utf-8?B?WEVPU2pUR3dhMG5lRm5hakNGZEsrS1cvNFlUeS9GNmFPZmw0WG13OC9iL1ky?=
 =?utf-8?B?M1lpMmplTnlWUDlzMmdGeGVDOFNCMm81NUdTWTh4eGx4SHY5cUlXbGFHSitF?=
 =?utf-8?B?dWNqRHN6cCtEUGk2NXJJN0JReFdVVVhnanNGS3plb0xwYUMvZUd3eU01NFc1?=
 =?utf-8?B?N1cweVhwTE14K0x6RFRaKzRvemtTaEl5OUhwaHBRRkxwVVU5R0ZRMU40MHln?=
 =?utf-8?B?dmFscjJCVk9wb1h3VFlNdVpXeitUcFo3K0xObDVaWlduRzZhdWVOZDd1bVZv?=
 =?utf-8?B?R3M2UHArZEdWUW1DT3pNV0tHbmRSSXNFUzFQL1I1bXZ3alh3SUZ6VU41WDMy?=
 =?utf-8?B?VktWSTI4Yy96dFNZZ1d3bFRsK2YxdERBcXZEeGxGbU5oN2ZoTTM4K3VMK25s?=
 =?utf-8?B?c0V2Q1JoaDI4WGdJN1lSajQvemFRRVBwZ0JrT1gwK2JMTnRhL3NvZHhubC9a?=
 =?utf-8?B?RFZuNkFtR2NLMC9DS093bDVpR1JaTFNJOVZreC9Ic0NvNTlJSWZ5Y21nYWw5?=
 =?utf-8?B?MFJ5OWxkZW1KZUJ4M2xyR2gxQWY4NlkxSkhVcmJHOGZJTDBYamdGaWpjMUxo?=
 =?utf-8?Q?/5FOAatiHQrE0vM7374CaRkbSyJN2kTs1RIpMF8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkhPNm50M2diVFkveW1IVWJ6RGNxRkYwQTNzTzluL3NQYUo0MTNDZ1I4Q0Ju?=
 =?utf-8?B?bzVpTk43VDdzK1VSUWlZKzhZaUNCbm54Y1REL0VFKzQyZlNFcDA4WmpPLzNL?=
 =?utf-8?B?cG93WjJ2RUdTQSt1YzZJZFhOVkpIRkxmSW5QSmlJUTdlaWg2WmlpdDU5aGxG?=
 =?utf-8?B?N284R1BWZHh4T2pvQ0YrcXZ4emFuNVhKalZ1dm1VT0dzcjNPeEcvNU85bnJD?=
 =?utf-8?B?K1RxbS9yU3BCbWhtRmNCWVFodTdXa0tMb1lpamVrbnpMN3dTR0dmKzQwL3RH?=
 =?utf-8?B?VFpkYUhwY2Z4aDZBNmtldmJ6cDhpVit2TUgyZHlUdXE3cit4WG9uNzFjcUd0?=
 =?utf-8?B?OUZvYm9lTjQ0TlpLZ3dxWXNFV0RjdTMwTzZZbVR5YTZkNXZ1VU5PNURzV0xT?=
 =?utf-8?B?ZW9JTXQzZ29XVjFhNTJxM0cyeW0vanVXT0owRXVMY1VPYzJBcUlqL3kvTmVl?=
 =?utf-8?B?VkxLU2lzTms2dGhwSEVKR09OMFUxOFRlSVBvQkM0YUJES1ZqZXZrUUJkZ0NJ?=
 =?utf-8?B?a0NpRjFLMmN2MzUwTHU1TkhlZkM1dzNwRW1hTVR3QndCRWRxRERLZmhINXVw?=
 =?utf-8?B?dVZzSTBacXR3K3dWd2RQd2N3N0t1YWxFaDJEUHFyRVo1N2R4blJjc2g1MDJM?=
 =?utf-8?B?M0ZleFpNQTNKME1BYkhGQ0czTVY2L2VCVnJaOXBEbmFteFlvQmZsbHFWUHpU?=
 =?utf-8?B?S1k2ZFVobW5kSXNaWjFHOWxJWmZaWTNKc1JtT0VEYVZXd08wVnZkSXYvSlFK?=
 =?utf-8?B?K0dSMlRUV0ZwSFBSNkkxK3ZWZ21BL29tZEJ4YVNSdG9XV1UrdnI4QnMvcGQ5?=
 =?utf-8?B?TEloazByNFBESGIrNDZGZlJSQVY1MjdTUVEwbGVvdnMyQjhDUmNGSXFWSVhF?=
 =?utf-8?B?MlR0d3VLVVRhc2ZuMUFFQnFQZTRTZGJZWU91RS9RemhLbjlvUnJXL25NK0tF?=
 =?utf-8?B?WmVHWWdWUUk3U0V0SlNQN1Fwd2I3ZDlwTlY3S3dUZ0tKRU5pNzNqY0VUbGpJ?=
 =?utf-8?B?cmlJaUppb2FsWm5IQTUwNmREeXFBL1ZKNFlzVnQzMUhGVHJtbkVJY0Q2Uzhp?=
 =?utf-8?B?T0U0cFhvdFhoNEQ3dmNNQUhpaWo0SjV4Z2wrdHNLVzFOVXh0N1ZEOEJ2ZlJO?=
 =?utf-8?B?V2MxdUFvWTlUemtIWnN6Vk9rc040cFZ6NGRpZDlHd3c5RmRxOUdZbUtPR0RD?=
 =?utf-8?B?eG9SVERpQStiR003QkdqQjVsaDBiVFZLZmJXVWlFclFPRWlFNGszeGFNVVQv?=
 =?utf-8?B?d0FxMFNGZ29peWphT253NkFYZ21FdXJQV21jK29kYTV6cWtZbVNpUC9hVkxG?=
 =?utf-8?B?T0JpWnMyVlBXMk9Hbk1ESi9zVWJadW43QXhKTUZBdkgzR2FXc2EwMnlDZUFt?=
 =?utf-8?B?MlR3VHFrU0RSV1padFY2S0dxRGFLa3lmNElDZkZ4QWh6VEtFY2h1bUJjaWVh?=
 =?utf-8?B?MTMxUG9nS2tpWUY3RUJ6aDZqK00rdVRWQWlCUzdHd2YvYVBiNnFQMldkUFRn?=
 =?utf-8?B?YXFRSktiTjZ2MnZVaVJMRUhmTHIrei8yREhXd3R5RXNXS1FRRU9WZGFUTnhN?=
 =?utf-8?B?N3J3MHY4SkZBZmRUN3JZeUYxRWJzQi9jTWZ0N2VjYjdLTmdqa0RYUUpaQU1y?=
 =?utf-8?B?enYwWEtBUGY4Rldab3NpYkUxSy9oeEx4MDF0Zi9yenJUeDlOTUxndXNDYk9Y?=
 =?utf-8?B?aUNhWGxXbXk1MTArWFl0WjY2QnE1QjduQXA5NFNqdVZyZnczYzJkQzV1ZFc5?=
 =?utf-8?B?U0gxenZwd2NGTU0vOXlBWjlTbGNKaWNnZ3ZFVFl4VmNLYk1mZHoxeWFBTWxr?=
 =?utf-8?B?dFdGcDVqWnY4N3lnZ1FJbzNoREsycUgzeS9RZmdKUnpCTVpPZXpzaUJ3L3h2?=
 =?utf-8?B?STd3MnlSbDdOWmN2ejROR1NGTXhtVVVUTHkyRzJDTE04K0ZvZjZHTFRjSlN5?=
 =?utf-8?B?c1RXSzNqcitTbUFLVWJtKzRlVUZRM3MvZkdNWGg2Ym03eDlzZjViL0xmQWRt?=
 =?utf-8?B?UllGTitkL3RuSDBIcm9mU3lBYU5DaUt0QzVaeXV0MkdocnhLYmZYc0hFSHNw?=
 =?utf-8?B?VGFZU2lBeFI5L3ZoV1NycWQ5ZGlPQWdpdXVQNVU3MmxaWmtLSWU5Sm1aR3ZU?=
 =?utf-8?Q?xDcF4qP7qmfH/+SG4eLa3wj7C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7579b9f-0528-4878-eacf-08dceeadf1a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:16:43.4314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPZBk730tPAsH/kV5YApGM36v5k+LSSuzKZkTw/ct/ftFD8w4SIzJqNBeQzUaJoU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/17/2024 6:37 PM, Liu, Leo wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: October 16, 2024 11:18 PM
>> To: Liu, Leo <Leo.Liu@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Sundararaju, Sathishkumar
>> <Sathishkumar.Sundararaju@amd.com>; Jiang, Sonny
>> <Sonny.Jiang@amd.com>; Zhou, Hao (Claire) <Hao.Zhou@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Save VCN shared memory with init reset
>>
>>
>>
>> On 10/16/2024 9:37 PM, Liu, Leo wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: October 16, 2024 9:16 AM
>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org;
>>>> Liu, Leo <Leo.Liu@amd.com>
>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Sundararaju, Sathishkumar
>>>> <Sathishkumar.Sundararaju@amd.com>; Jiang, Sonny
>>>> <Sonny.Jiang@amd.com>; Zhou, Hao (Claire) <Hao.Zhou@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: Save VCN shared memory with init
>>>> reset
>>>>
>>>> Am 15.10.24 um 08:23 schrieb Lijo Lazar:
>>>>> VCN shared memory is in framebuffer and there are some flags
>>>>> initialized during sw_init. Ideally, such programming should be
>>>>> during
>>>> hw_init.
>>>>
>>>> IIRC that was intentionally not done during hw_init for some reason.
>>>> @Leo do you remember why?
>>>>
>>>
>>> We need to keep some of the status from share memory(driver and FW),
>> since some of them are changed by FW, that is why the init cannot be in the
>> hw_init stage with suspend/resume case.
>>>
>>
>> For vcn_v4_0_3, the flags that are initialized in sw_init are these
>>
>>                 fw_shared->present_flag_0 =
>> cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
>>                 fw_shared->sq.is_enabled = true;
>>
>>                 if (amdgpu_vcnfw_log)
>>                         amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>>
>> Is the flags initialized during sw_init required for FW during its initialization
>> stage? If not, it would be better to move this to hw_init.
>>
>> Some part also get modified during vcn_v4_0_3_start (which is after hw_init
>> during runtime) -
>>
>>                 fw_shared->sq.queue_mode &=
>>                         cpu_to_le32(~(FW_QUEUE_RING_RESET |
>> FW_QUEUE_DPG_HOLD_OFF));
>>
>>
>> One reason probably is hw_init is also called during resume which restores
>> the saved bo during suspend. So this may be to avoid the double work.
>>
>> Anyway, is the patch okay to go?
>>
> You need to fix the function name as I commented from last email.
> 

Any suggestions - amdgpu_vcn_save_vcpu_buffer/bo?

Thanks,
Lijo

> Regards,
> Leo
> 
> 
>> Thanks,
>> Lijo
>>
>>>  +int amdgpu_vcn_suspend(struct amdgpu_device *adev) {
>>>  > +    bool in_ras_intr = amdgpu_ras_intr_triggered();
>>>  > +
>>>  > +    cancel_delayed_work_sync(&adev->vcn.idle_work);
>>>  > +
>>>  > +    /* err_event_athub will corrupt VCPU buffer, so we need to
>>>  > +     * restore fw data and clear buffer in amdgpu_vcn_resume() */
>>>  > +    if (in_ras_intr)
>>>  > +            return 0;
>>>  > +
>>>  > +    return amdgpu_vcn_save_fw_shared_region(adev);
>>> The saved bo here is not only for fw shared memory, also for FW runtime
>> stack/heap as well.
>>>> Regards,
>>> Leo
>>>
>>>  > +}
>>>  > +
