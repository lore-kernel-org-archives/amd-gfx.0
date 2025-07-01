Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65956C7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 14:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063B010E5B6;
	Tue,  1 Jul 2025 14:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="knyZk5n2";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D3210E5B6
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 14:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6T1GJ/0UdncA67UqY+bquFB1XsFrbSSUPeN6RJ1yYFQHeSPRzm/L37w694lAyfN9Aq4hD1kDC7wegKhZU2WISychaasycLW/rKA9Lcdytn/tRwwTavzNLIHApDBAMbLskuvStm59RTmE/hrstmrKNU6Vk7KE264/DJUnNKQIwIoOww8o9xlfVkpJHzWVL6rcNVJpkx8tAAQZWrlbz/udSLwRq/tTYYyuaTT3lDK3MTNDflq0jWszSrjWQ4/DUWSpkIW8PLtLlyLzkGxdgvvlWBlu1dlZlZHaVdABDACJqhi961D9dXXIk77OFCxb5F5czwoD+N0tp1Vv3+udqi9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mxWHnkDILOalqcApf1GBH905pL+bqkcgPP+laFwtas=;
 b=kz3jYaqlPOkP+QpMul+J6OzrmBumK5OQLhVNskI0uvwUnvHDerxd0xQwn9/EPAK6wDZ3ugf5XRIdgsLNwuL268/DBMLcPgv6vzCwqz2lRCkpd298Le05+iRyammwHWKDyp6mub23n4uV+Ox92M8RLmXJAud34wNdBNwZypPJBBEVX/MfKytO4XEJBzXsdBeDLD6R/UVIER+ejDOGBYmaivgQLbYEQ1YmzGZIIaRUECKnxDJgsR1QuHGP1HQzUXCf4B9NyCQQhAQkELjo1jMkVzAHbYu+1VcSpRsW3Wd9l9yQXx30uk4e37/4aCkOjhB5Xg1b0MvvBVPsX5iev5SFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mxWHnkDILOalqcApf1GBH905pL+bqkcgPP+laFwtas=;
 b=knyZk5n2iJ7zpMwkkp61yNiv1qD6ggCxFACoN8Xc8BmA/NRAIE7L0OXhARmFLvO+pVJulnMdcWg+PFnirw1BV6qnvogfhwnnwrssEptj0PxoAfY5Sm7fKLlZbf7WtFHSvKpIQ0oyiq8oxp5AbY5L9Qy6xZMbWSFQ+hgW6OSQqbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9819.namprd12.prod.outlook.com (2603:10b6:8:2a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 1 Jul
 2025 14:11:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 14:11:39 +0000
Message-ID: <94f6ae89-5b7d-4541-a119-c0bcf862288c@amd.com>
Date: Tue, 1 Jul 2025 16:11:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Unify Device Aperture in amdgpu_info_ioctl
 for KGD/KFD
To: Alex Deucher <alexdeucher@gmail.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 David Yat Sin <David.YatSin@amd.com>
References: <20250623111717.224707-1-srinivasan.shanmugam@amd.com>
 <20250701064459.287603-1-srinivasan.shanmugam@amd.com>
 <CADnq5_OyF=E23TrceinSnt2fFntUB3DBP0cRfUgh9JeAgPfYFw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OyF=E23TrceinSnt2fFntUB3DBP0cRfUgh9JeAgPfYFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: b79450c3-1a40-443e-a319-08ddb8a932b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1lwVlJickNUS1kxY25nVkpibVB3V29DdkhLNlErWUhkK2NnUG5ORVBaeEVG?=
 =?utf-8?B?N0U1R3Y0d3dUWmwxMUpoeHROYTlMK2x1UDJhOVlqOExwS2JOY091a0R1anBO?=
 =?utf-8?B?dkN1YkpveGtWR0NNemNUQVk3OVdkN2laVjNaR1RuV0M2ajJnUDRuc1AyQmRh?=
 =?utf-8?B?UDBMQ2ZKSGc5dFE2enVydC83UVdOcml4cGxLMFRTNEdXYWcrRHZTWDVvQ1RQ?=
 =?utf-8?B?OWZCU2FIaVNnRkVMSzg4SEN5UDB6TTJKT3hkR1NTT0FxMGhtd2VGUTY0cHRU?=
 =?utf-8?B?L2tHejFmV3JPemNldzZUTVZMNVpvVjJ5WWViQUc4c1Z0S1gxN2prbzZnNDRO?=
 =?utf-8?B?TWdZb0J0K1c4UnhxWTBTZHhZbC9GZjdhaUs4VmpROFpvakVWVXo0K1lLdEQv?=
 =?utf-8?B?V1ZLQ1drNGIwY2JkK0g2V2hZUHNhZHZuWHB0eGdMMzd4eEova0prZi9xTTlp?=
 =?utf-8?B?YklFWENtUms2SnJDNHllR2FTVnlRTGRxelJSRFFSWmUydmVqdmZZK1pteEll?=
 =?utf-8?B?THNzdWZWcGtNU0EyK3NVWlEvNDN3djh6Uy80N2VOeFFaUkpkRy9uQWp1OEQz?=
 =?utf-8?B?Rlo4VjZjRnZNc2loZHRzYXB6YzlJbXR3UCswbWdYMVhBTkdJdmpIZFZoQlJO?=
 =?utf-8?B?dFpCVi9Rb2lmZTNKQ1lPczdHYXJyUmw1U1h4Y0djMnFFaVNwZzE0UGlMY1JZ?=
 =?utf-8?B?Tmo5T0MwQXpFazVCajdtcmQrWnUyY2RQbk1FUS9MVW5Ed0R4aUtwMU9nZjAy?=
 =?utf-8?B?bmJoWnUzZEQ1Mlo5bitVUXdHMHVVTW9JTkhvM1MrUGlMOXFYWllhY3ZiU0pa?=
 =?utf-8?B?TGNPRjJhSWJtQXkvQWFuaTN2bll5Vmt4RlBza2dqOU5SWVNMMnhrOVZxblhP?=
 =?utf-8?B?b2V5U0l5R3lDWGVaVjBpUmNSOGxnMlVZRlR0T0g3MmNXQjMrN2cweWJLcHZT?=
 =?utf-8?B?a2h5eGFHZTNnekhvdnNKbm1Rem9PUlJlMXlnd3dSSjlpaDRhczBZS2w0WFBJ?=
 =?utf-8?B?aTM4dXloWC9SemhBeTloR3g5L3F6QmhLaHZaUjN2S0pPVk0xYUF0NCt1ZFMy?=
 =?utf-8?B?bWRPTjJZOHJ0cDk3YlZIOXFiU2pOU2VLK01JemtHeERTODRKZ0JqM3Z5Q3Av?=
 =?utf-8?B?Smx0UU1KVC9ELzc1ek81RXJTOHMzNGhORVR4TmJlNmR5WVpYU24vaXNkTXB4?=
 =?utf-8?B?cFhkUU9iMW8xN3VLUmVWNlozUzZLSmFuZ3VQYUxaeXZvckdlcEpObkMzRVdS?=
 =?utf-8?B?aXRDRU0wM2RaUFdGWWg4ZDVyRW90c1RsakZvQis0RDYzMDM0b0xBOElqcTdZ?=
 =?utf-8?B?WGlsSC9EME9YcHVxaTFXaUMzYUpEYitIWEl2eUNVdHdGMjBMeFpBTXZFMnIw?=
 =?utf-8?B?ZTdNNk9hN1ozR011NTFtVm9qV2ZoWm1RaWVXVnNTVTNrU21YWHpvMkx1WWI1?=
 =?utf-8?B?MVBrY01ZSEt2VSs3bjQ3SkQ3Vzcybmo5QWJ4UDF6M0dFTG8wZTlGUlpMMkxY?=
 =?utf-8?B?N1pVc3JNcjZCNEp4a3pDT3NxMG50UDVGQkRIWHBnRU9pR3hTQlIzdVA2aHM2?=
 =?utf-8?B?NmhPMHRpYzR5TENNRmlLV0lEVXM2eUx0SDlmMTBkYmpSVE1ydXpuclQ4YjJY?=
 =?utf-8?B?T3BZMFJTeUNuakpxMnZpUDA5M3ZPTXJzNG0rQWYzUkFXeVRlbXVHOURDTzRX?=
 =?utf-8?B?SENuZmxsMlpOalBmQ0VMMUZPUmhpZElVemhoMC9vTERuWmVhNGtiOFNQYUJQ?=
 =?utf-8?B?cXF5UVVSbjkzWFFZTWJ0Mjk3b1FuWWhSdVR3UkdKOTQwY3FxbzhxNUhtVzky?=
 =?utf-8?B?ZVJlN3E5OUtoc29lQUt4YkR1RVl5ZWt1R0Fpank5WitQc2lmZmxLeTVtQ3Bw?=
 =?utf-8?B?MWJ5WVNGSzJST3V5VnVxeUJPcWhsTVZhbE1OSVlXSjJLRlowT1pISHNRUVB5?=
 =?utf-8?Q?M99jpSj1BCk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2x2clpLd09TbU1CdFRlRUJXM1N0MmczbUFiTmtKOWptamE3b2NwM3hUSTEw?=
 =?utf-8?B?ZWVkdVJJU0hWVlUyclJlQXZVTGNoVHR1Uzg0UkxwcUlQUnRtWlMxQVBrYzBz?=
 =?utf-8?B?anJ5RDRhcFErL01DcDU3aU5QQkVoa0lRRW5HaXJrKzJyeUpCOGthOUw1VS9s?=
 =?utf-8?B?L1VTeCtaNDVuU09ZWGc2NEhKbDVMdkUyZDhYbHZGMlg4TDBHMDFBS1VSOEdX?=
 =?utf-8?B?czZzbWQvNk8wQ3prbHZBa3N3dXVuOGZiSnQ0eTNTTlA2UTh4Mm55cjV0NU9E?=
 =?utf-8?B?SnE4ODlCOGRON3grUFlOeFdIY1JmeUpBWHc4MUVUd3ZDYmFmNFV3SzdzamN3?=
 =?utf-8?B?bURjTXdEczNKQkxSWEtDa3VyeFNRamxQcS9yVE9oVnJ3VndIQkFwRG5URUdn?=
 =?utf-8?B?Wko5dUxEdzdHeXVweXVHRTFtNDByRXpmRTViQ0hTaGZCNmZHdWgyRzB2WHd2?=
 =?utf-8?B?aXZ4VE5vaDY5a3hyU01HbkxBclc3LzBvOXJINFljdlVYVUo3WGNGeGwzeG1M?=
 =?utf-8?B?bGhtd0E5MWNtdnoyaXA1ZTJ2cVF6NFovOUhDdG96SlY0eTBnUkd5T3J0Z2d1?=
 =?utf-8?B?UEFaQ0FFM1JOT2ZLQU9BR255WXlGWFNDRk5vK0F3SUtqelBmL2doYWhzSVRr?=
 =?utf-8?B?cjRGZiswQ0RJSHB0elY5VmhCM0lRQmdOeFVFOEQ2NFBsTkFjR09SSVdBTmty?=
 =?utf-8?B?T29Ga1pJTks3MHB6elloc045LzJXRTVabVZRcW5QdjBoQXl6dTdRalhiTlh3?=
 =?utf-8?B?NVlXdmJmNUpDcjk3dno2STRvUHJHMk9ORHJKMGk1SmxjSFAyY0RVMDZRcG0y?=
 =?utf-8?B?cDRmWlFjbUhDY0FPcXB6aWZWK3NZRU1hNFk3NExVVkRYWlBQRnhrMlpMYkVq?=
 =?utf-8?B?Tkg4WjBwYTYrMkl5U21ISzdlSENGY0t3cE8xdEVmbzFyTTNPNE1rUGZKYnV1?=
 =?utf-8?B?Nk0yWjhKZmdCT290cGNqdnBJWTZlVm8yM1FxbG1RMHQxZGJEcjJKT3YwMVp5?=
 =?utf-8?B?UFdYU2szdjVCM3hXdHVHd2xkMVFJSTdZeFVrZG5MRnNqZ3BVcnd0NWc0OWM1?=
 =?utf-8?B?emdaaEIzVzZYZGdDZWxMOVJPaVBGL0hXMEw5akxVMlZyb3R6Y3h0VXZETm1J?=
 =?utf-8?B?WE9oWkErVmxncVM4akZFNzduSlZoanl4dHNQenFYTGtqcnprMTU3ZU5KRmU1?=
 =?utf-8?B?bGh0b1orNngyWG1IRFNaNXhHTFlsMmdOQnVRSDJLTEVZNDVOM1JHcnRFVlU3?=
 =?utf-8?B?VHNhUXFPcmVybWZpYkJKUDFqTDBTYlkrMXJndGdObXE0eVJNc2xSNENWcFpG?=
 =?utf-8?B?eFNtQ29yb1lCV29VOWladTJtbDliNUF1RjFRQUFYaDlJMFZuQ2I2TnBsbWw1?=
 =?utf-8?B?WDdpSmtLajdnT2N4bVNSdTM4Y0lTRi9lSXNJOTdnazdRdlBBRlU3dkRTeUd0?=
 =?utf-8?B?TnVVaTFOdkQvMnJsMHg1bkVsTW1Ta2MyTEJyekJwZmRScm1Lb1F2Z0xSWjFP?=
 =?utf-8?B?eTcveXNyZ3RBLzFib3lMOXM2NjMvYUE0K0tyNDh2UlZGeWFoOUpzRUtMWXhS?=
 =?utf-8?B?OFQySEQ1akZkVnVoWHo1M3Zld3ZBY3IzbkJxdkJLYXNmaVdZQ3NsMFZNaHFP?=
 =?utf-8?B?NFlCaU1ZYVlEZFU1RU1mRnFTQkE3dnVydVpmOTNzU0xlUmhEM3RURkxvNm1l?=
 =?utf-8?B?UkwvMk9iTjlEbzNXdllYbTJxaUQvaFIrNWx1NC9GdS9NaGNuZXRaa2F6Vlo1?=
 =?utf-8?B?L3ZqOFhpNEZRU1FWcHdLVG82LzEwYmVFWW1SdVNFNk9weGVlMmJ0OWFTSWJx?=
 =?utf-8?B?MWJobk0zb1ZMdkR1LzZ2UFpsYlFwVW9UY0M1Ym5aUW9EYmNrenNwWUxPN1U0?=
 =?utf-8?B?QktQS3dyRzVhR1FObjZ3OFI2cUpRZFJGeXNNbmJyZzlJNDAvVUFCeFhvOGhC?=
 =?utf-8?B?azQ0ZUcvYm1JUWtsR28wVzRkQTMvRjlJWTFwWWlrM2lHWmhQZTRjWHVDM3ov?=
 =?utf-8?B?TmE0dWlnODFjaE1YN0F2OFhyaG1TMmtjVUZMWWVRcGFPdVFTVFQ2cDVLL3Jx?=
 =?utf-8?B?MzZOVFlqZ2RtNkE2ZFNkYXVaS3Vmb3JCVTVZRnlURWdlbXBwb21VelAvZlJK?=
 =?utf-8?Q?BvXUTLMRrqU9B5J2EaR9fzmzK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79450c3-1a40-443e-a319-08ddb8a932b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:11:39.8404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGBn8J82vDekbvJ0+b/KdeSMCogsIHrFLKGmLDGRwpq3lRe7PATjIaY0Sf6XeXwv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9819
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

On 01.07.25 16:07, Alex Deucher wrote:
> On Tue, Jul 1, 2025 at 2:53 AM Srinivasan Shanmugam
> <srinivasan.shanmugam@amd.com> wrote:
>>
>> This commit refines the amdgpu_info_ioctl function to unify
>> the reporting of device apertures for both KGD and KFD
>> subsystems.
>>
>> v2:
>> - Use amdgpu_ip_version() instead of directly accessing
>>   adev->ip_versions. (Alex)
>> - Added AMDGPU_VM_ prefix to scratch and LDS base and limit macros.
>>   (Christian)
>> - Clarified in comments that the top 16 bits of the 64-bit address must
>>   not be 0x0000 or 0xffff to avoid sign extension problems. (Christian)
>>
>> Cc: David Yat Sin <David.YatSin@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> as well.

> But don't commit this yet as we are still waiting on the userspace
> side to be complete.

Mhm, how do we want to do this with the ROCm?

I mean for Mesa we usually wait for the merge request these days.

For ROCm we just wait for it to end up in thunk or libdrm or what?

Regards,
Christian.

> 
> Alex
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 25 +++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 23 ++++++++++
>>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 45 ++++----------------
>>  include/uapi/drm/amdgpu_drm.h                |  6 +++
>>  4 files changed, 62 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 4aab5e394ce2..76d902342271 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -46,6 +46,7 @@
>>  #include "amdgpu_reset.h"
>>  #include "amd_pcie.h"
>>  #include "amdgpu_userq.h"
>> +#include "amdgpu_vm.h"
>>
>>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>>  {
>> @@ -1031,6 +1032,30 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>
>>                 dev_info->userq_ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>>
>> +               /* Retrieve Device Apertures */
>> +               if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 0, 0)) {
>> +                       dev_info->lds_base = AMDGPU_VM_MAKE_LDS_APP_BASE_V9();
>> +                       dev_info->scratch_base = AMDGPU_VM_MAKE_SCRATCH_APP_BASE_V9();
>> +
>> +                       dev_info->lds_limit = AMDGPU_VM_MAKE_LDS_APP_LIMIT(dev_info->lds_base);
>> +                       dev_info->scratch_limit =
>> +                               AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(dev_info->scratch_base);
>> +               } else {
>> +                       dev_info->lds_base = AMDGPU_VM_MAKE_LDS_APP_BASE_VI();
>> +                       dev_info->scratch_base = AMDGPU_VM_MAKE_SCRATCH_APP_BASE_VI();
>> +
>> +                       dev_info->lds_limit = AMDGPU_VM_MAKE_LDS_APP_LIMIT(dev_info->lds_base);
>> +                       dev_info->scratch_limit =
>> +                               AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(dev_info->scratch_base);
>> +               }
>> +
>> +               dev_dbg(adev->dev, "Node ID: %u\n", adev->dev->id);
>> +               dev_dbg(adev->dev, "GPU ID: %u\n", dev_info->device_id);
>> +               dev_dbg(adev->dev, "LDS Base: %llX\n", dev_info->lds_base);
>> +               dev_dbg(adev->dev, "LDS Limit: %llX\n", dev_info->lds_limit);
>> +               dev_dbg(adev->dev, "Scratch Base: %llX\n", dev_info->scratch_base);
>> +               dev_dbg(adev->dev, "Scratch Limit: %llX\n", dev_info->scratch_limit);
>> +
>>                 ret = copy_to_user(out, dev_info,
>>                                    min((size_t)size, sizeof(*dev_info))) ? -EFAULT : 0;
>>                 kfree(dev_info);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index f3ad687125ad..fd8f6da30096 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -184,6 +184,29 @@ struct amdgpu_bo_vm;
>>  #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
>>  #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
>>
>> +#define AMDGPU_VM_MAKE_SCRATCH_APP_BASE_VI() \
>> +       (((uint64_t)(0x1UL) << 61) + 0x100000000L)
>> +#define AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(base) \
>> +       (((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
>> +
>> +#define AMDGPU_VM_MAKE_LDS_APP_BASE_VI() \
>> +       (((uint64_t)(0x1UL) << 61) + 0x0)
>> +#define AMDGPU_VM_MAKE_LDS_APP_LIMIT(base) \
>> +       (((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
>> +
>> +/* On GFXv9 the LDS and scratch apertures are programmed independently
>> + * using the high 16 bits of the 64-bit virtual address. They must be
>> + * in the hole, which will be the case as long as the high 16 bits are
>> + * neither 0x0000 nor 0xffff to avoid sign extension issues.
>> + *
>> + * The aperture sizes are still 4GB implicitly.
>> + *
>> + * Note: While GPUVM apertures are generally not applicable on GFXv9,
>> + * there is at least one APU case where GFX9 has a limited GPUVM aperture.
>> + */
>> +#define AMDGPU_VM_MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
>> +#define AMDGPU_VM_MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)
>> +
>>  /* VMPT level enumerate, and the hiberachy is:
>>   * PDB2->PDB1->PDB0->PTB
>>   */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> index 1d170dc50df3..291b068aaf8a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> @@ -276,35 +276,6 @@
>>   * for FLAT_* / S_LOAD operations.
>>   */
>>
>> -#define MAKE_GPUVM_APP_BASE_VI(gpu_num) \
>> -       (((uint64_t)(gpu_num) << 61) + 0x1000000000000L)
>> -
>> -#define MAKE_GPUVM_APP_LIMIT(base, size) \
>> -       (((uint64_t)(base) & 0xFFFFFF0000000000UL) + (size) - 1)
>> -
>> -#define MAKE_SCRATCH_APP_BASE_VI() \
>> -       (((uint64_t)(0x1UL) << 61) + 0x100000000L)
>> -
>> -#define MAKE_SCRATCH_APP_LIMIT(base) \
>> -       (((uint64_t)base & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
>> -
>> -#define MAKE_LDS_APP_BASE_VI() \
>> -       (((uint64_t)(0x1UL) << 61) + 0x0)
>> -#define MAKE_LDS_APP_LIMIT(base) \
>> -       (((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
>> -
>> -/* On GFXv9 the LDS and scratch apertures are programmed independently
>> - * using the high 16 bits of the 64-bit virtual address. They must be
>> - * in the hole, which will be the case as long as the high 16 bits are
>> - * not 0.
>> - *
>> - * The aperture sizes are still 4GB implicitly.
>> - *
>> - * A GPUVM aperture is not applicable on GFXv9.
>> - */
>> -#define MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
>> -#define MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)
>> -
>>  /* User mode manages most of the SVM aperture address space. The low
>>   * 16MB are reserved for kernel use (CWSR trap handler and kernel IB
>>   * for now).
>> @@ -319,8 +290,8 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
>>          * node id couldn't be 0 - the three MSB bits of
>>          * aperture shouldn't be 0
>>          */
>> -       pdd->lds_base = MAKE_LDS_APP_BASE_VI();
>> -       pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>> +       pdd->lds_base = AMDGPU_VM_MAKE_LDS_APP_BASE_VI();
>> +       pdd->lds_limit = AMDGPU_VM_MAKE_LDS_APP_LIMIT(pdd->lds_base);
>>
>>         /* dGPUs: SVM aperture starting at 0
>>          * with small reserved space for kernel.
>> @@ -336,21 +307,21 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
>>         pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>>         pdd->qpd.ib_base = SVM_IB_BASE;
>>
>> -       pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
>> -       pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>> +       pdd->scratch_base = AMDGPU_VM_MAKE_SCRATCH_APP_BASE_VI();
>> +       pdd->scratch_limit = AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>>  }
>>
>>  static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_t id)
>>  {
>> -       pdd->lds_base = MAKE_LDS_APP_BASE_V9();
>> -       pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>> +       pdd->lds_base = AMDGPU_VM_MAKE_LDS_APP_BASE_V9();
>> +       pdd->lds_limit = AMDGPU_VM_MAKE_LDS_APP_LIMIT(pdd->lds_base);
>>
>>         pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
>>         pdd->gpuvm_limit =
>>                 pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>
>> -       pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
>> -       pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>> +       pdd->scratch_base = AMDGPU_VM_MAKE_SCRATCH_APP_BASE_V9();
>> +       pdd->scratch_limit = AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>>
>>         /*
>>          * Place TBA/TMA on opposite side of VM hole to prevent
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 66c4a03ac9f9..f285e9325d06 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -1477,6 +1477,12 @@ struct drm_amdgpu_info_device {
>>         /* Userq IP mask (1 << AMDGPU_HW_IP_*) */
>>         __u32 userq_ip_mask;
>>         __u32 pad;
>> +
>> +       /* Additional fields for memory aperture information */
>> +       __u64 lds_base;          /* LDS base */
>> +       __u64 lds_limit;         /* LDS limit */
>> +       __u64 scratch_base;      /* Scratch base */
>> +       __u64 scratch_limit;     /* Scratch limit */
>>  };
>>
>>  struct drm_amdgpu_info_hw_ip {
>> --
>> 2.34.1
>>

