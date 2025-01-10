Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F997E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 19:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18DE510E0F9;
	Fri, 10 Jan 2025 19:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="upCrzJl7";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D8910E0F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 19:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJMHgdSEwRYZKaJUrzvBZP7nxayzDWAnB94lnc3NXZ/3buXhlr62sV8BYT0Hl/FNRcsUhfPehH4Q/WTMx7H7ZYBORxLECM0kXlrz4ryKVAX/tlA/RYnmuB78LChW0CXRyuYGACRFS4YLt/Uj1jd5+DpHkhD5rfSTZ5mmGxpGKPNANF9rAjIDxuik0PdqsyW1MTF+ckkHpiMrrRe9pcshx3E7/EC4vV/8xm17E9JpeMziUv2HynmulpT1l+OVCG/0xtqknZRvJCksU4gUz+khvZx3Vlu7i2PqrtM54+HgkhH94Qlb0tFBJ+5UywZHawo2mh/5x8xodNEBod09YJ9pjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A9A4W2T2x6+HBDBxQ5n6F0h82SteIPDVz/zylSnt94=;
 b=jnOqfqoRAKnXO8tD1qfWTMiLdprwgosPd4Vpefl3WWrOdXRQ9lHt3nO7GOmlIze3s9knZLlS2OSK37mjxpOjDQQd3laNaJKjbatUEDakYhmwBoXjrU6hYKzMvltb66XRees6KsQMl9yx4sCP+MJH1nbZyraaLkYYf3cjWuBARC3Pst27DtmcUeo3AZVYjlIbIL+uS1SXc2Q4+xTXw/XMQ5AjCHa4Rh/trdKIqUO+KM9wig+gr9Rm3BbyWCgj0QFPq2iNiLJP6LfZlLHLQ4LjjyvwTcM/5fXq/cGLjpWpPWGHDZ6gvx9bxqSiXwWKWkdxcykoXSz8T/815KEJUxUi9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A9A4W2T2x6+HBDBxQ5n6F0h82SteIPDVz/zylSnt94=;
 b=upCrzJl7OgcnkUWRNwW3Ge0HCRQ6mjwCtnUPIyE1ECZem/D/8KCw+H414yZ7O1Q2K5Qvmnp6Dh2naJrRnr53sljAsFpcebHvWcvhJBzWvLi0F7fz2gTkwCYDM+k83FB5hltNvDs6MPU1I15wW+0GrWS4Srp5YLMXTJXRcF9e8kI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 19:45:15 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%7]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 19:45:15 +0000
Message-ID: <fed57f7d-a0a5-4946-9f87-1dffde14eb21@amd.com>
Date: Fri, 10 Jan 2025 19:45:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Clear MODE.VSKIP in gfx9 trap handler
To: Jay Cornwall <jay.cornwall@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250109175613.6265-1-jay.cornwall@amd.com>
 <20250109175613.6265-2-jay.cornwall@amd.com>
 <CH3PR12MB907922CB4C7C932825882BFD831C2@CH3PR12MB9079.namprd12.prod.outlook.com>
 <d72b85bc-9fd3-472e-b5cf-e5f83d4aa6c3@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <d72b85bc-9fd3-472e-b5cf-e5f83d4aa6c3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::19) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1ae520-514e-4572-097c-08dd31af4de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUMrYlNRcCtOb1JkSkpsUFU5dTJ2WjNZOWg5WkVuTHhlR2k5aVE4SUt6cERh?=
 =?utf-8?B?WWRld1V5V3RZZHFRZW1SMW9XSW5rTURvYkFHV3ozUWhlK2lQeUllbmRMcDJK?=
 =?utf-8?B?NCtRdnZSanZTVFB0OFQrYmtnWGRqSkVva3ZtbHB1N2VwcmU5cGsyR3VMN2Jl?=
 =?utf-8?B?WkJRaDBFOWJjeitjQnlvZS9sd1JpSGUyYjR6VTFybURZSW55L2o4Rm0wNHY5?=
 =?utf-8?B?SzNwOHMrN1lwVFlJdkNEZm1nTDNlSjVHZWE3NmtTK3FoelU5eGlYdXpIY3hJ?=
 =?utf-8?B?RlRxSU1OQWF4aGZYbFB0MVVVT3hyRG4yc0trenpPeGNxeWVDUUIxRy9zQmxZ?=
 =?utf-8?B?eGFjSGE1THFkbitXcTk1WlVBOEhBRWxMYzh1VElGSTZ4ZG53NHRlMWg5clNp?=
 =?utf-8?B?cEttRWozSFk3bkFTaW9iNlNhVjllS21HUVVBQW5rYVBWakhlMHh2bitIRlIy?=
 =?utf-8?B?bEE3ODUybHRkaHZMTlE2OHlmbGVnN05EbEJ6ZVcvams1OE5WSFdjbTc4NFNR?=
 =?utf-8?B?L2E5c2NZT3hVR3paTWlLV20rK002QVowVTV5TTMxemM5a3NpQ2c3WjlVMUhK?=
 =?utf-8?B?eW44Skl3Vk9YQmhUZVhGQXRWQkVhWXlxdTBZZThxTzBmMTdVaGd5dXoyN3ZY?=
 =?utf-8?B?VnRRbDNHQzAyTVhOdDhtVzd6ZGtxVXkwd2RUNytpNEpKYWhNQzdCTTVjaDdP?=
 =?utf-8?B?eW9tVXdJZGlwTWJZNFRDUVdsWXhKdndOTEU5dG9DV1FKaTZtUUtreC9yNmxZ?=
 =?utf-8?B?VGUrZitkK2ZhV0s5dm8rQlMreFhwRXNPbnYzZ3RMNXR6Um9Nc3RYUGVLY3NF?=
 =?utf-8?B?TFJta1Z6NVlDZVk4REZ4SE1MbS96VXMraUY1Q2oyZjdkay9RMzQ1dWFhd3Bl?=
 =?utf-8?B?TURvQTBsbTI2aStVL0p3NmduOUZENFpMRkM2MytrR0t4SFVUbFNpaWgrNUdI?=
 =?utf-8?B?cHMvOFdseHRPZ242aXN5V2tmMEhzUHlpaEE1ZHNmUDRteW5yMHErSEhoTGpq?=
 =?utf-8?B?bk1GcDJINWtMRjdzUk9uUVRrWEN4YTBESHRqU0dHYWhqVUR0ZE9wT3hDNTMy?=
 =?utf-8?B?N0RPMmkyOG1pWXNJRHVtOU1teW5LK21YamF5Wk5DWnV4S2NIeHR4WUU2c1BC?=
 =?utf-8?B?MGI3OGNqQ0YzNU1NZGlsMjdDUUF4dmM3Q0lyL2ZMQlJiWkxvRHVXNWNremta?=
 =?utf-8?B?WEZRZURETGQ3N2tCNHhuNnU3N3BzYUNnUXF2N2ZyTnpyUWdFSmpldjUyMUJ4?=
 =?utf-8?B?K0RJYjgyU3hDZFZRMTNSSHMrNlpCQlRXbXh1aTIwM2lBOG1uZW5pQ3phQ2t1?=
 =?utf-8?B?NUk5U2E3ZXFKWi9ORnhVb3laS3RBc2JhN2E0VTZ1emg4RHRTOGw3ZDI3Y2JF?=
 =?utf-8?B?SXJJZS9CYzFMZE5SSjlTQWtEWkpkUHFISml0RlpSMEdPMksvRFpQb2Y1Z29V?=
 =?utf-8?B?TlZUUlBZTU1kcXBoRzJqZStqeW4rbW1DcEJFNUNTSFl6WjErVlY5Q0RIa3hS?=
 =?utf-8?B?ck9ZeXR0UkZqRVZuc0VrVHd0NHZmd01YWjlsT2QzZ0lEcWNPVXZMM0M5UEJL?=
 =?utf-8?B?TzdOZzBUR1ViTzd3UUlPL0FwbHJXT3NHK3FDT053c3RTek5FdnFwWE42Z2lr?=
 =?utf-8?B?bEQrUzZ1WVBrOGVmL2JwYW16MUVIdFhER0c2MkdSdVJpQ2swUGZWblRPMjBR?=
 =?utf-8?B?dGpRaVhZTlh5cE1qZklMN25IMXFWVEtDSFZMTlVLTjRCaHFXY3lQNzhicWJw?=
 =?utf-8?B?OWRTRHN3UjVrM2luM2huUGpmNGlLenNsdWMwQ0ozenNEanhZYmZCL2t2UjJP?=
 =?utf-8?B?d2RWZDNvWVUvMkEvSkRYQ2QzNHhRR0tCQ2pWSnJZdmZ2dU1uVlQ4SlN4YmJJ?=
 =?utf-8?Q?/d2twjEKtY1eF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SS8yTEhKT1R0S1h4bGF3VEpMN2trbW1NNG02Mm91R3I3cW1xRTVrOUIxTkpY?=
 =?utf-8?B?ekh1MEYxU2lyL3lTK280cGFVTEdLK1B5YzZjb25tTGZNWWZ4OFBLdkZscUpL?=
 =?utf-8?B?akNTTFZMem5NdU5PT0ZselFBUlpjeW1DRmJiaFB5UW1pR2lOdGdTZ01zQlR2?=
 =?utf-8?B?RXlJWTBzSlZldHVZVEpXQWxSN1J4V0RhWWRDOXlvRmFxYkgvWXBRenlPM3lq?=
 =?utf-8?B?MGhLZmhwaGVUVDFXNEtNQy9wT1NjUitEZ1dWTE9wSngxVThaWFlxcHF4QWlU?=
 =?utf-8?B?bGpYb0NUSU9rZkRockk4YlE0bVJLTDUrckVXN2JnaFF5b0FVcTlaQ1RMeFVz?=
 =?utf-8?B?L3hQR2JuZ09TWk9EUVNMTVNHVlBSK3BnM01JYlRvTWJwU3pzUWJjMm4xREhw?=
 =?utf-8?B?WUpwUDlEMGJzaGNnZTFPNkFTbDl1M0ZzOHJjUjNJaDZGbUpqNWUvWEt0Y2w4?=
 =?utf-8?B?SW00Y3BQTWxOU0E4eTI2RnErcyt1YjY2ZzJGUEdqZ0JhbCszazd2RCtaY1JG?=
 =?utf-8?B?K0pPZ3l3bjlTaDZVRWlLRVlXamZsWndhMGtDNXpWc290cDdSWmI2RFlQbUwv?=
 =?utf-8?B?ZndYUE00UEtTbERONjR1TjRoQkhwblVIbXlvZGhUdGRMOUhNRTQ2ekpyd1hl?=
 =?utf-8?B?NUttUEN0RDFFRUZic0VtOC9LTXNaMHVkSlZ4YXdrYTNWLzF2Nnd0U0tDUCtO?=
 =?utf-8?B?Tk1uLzdoaCtqSkR6dkR0WVlYREhxaGV1NmJoUVA3dU1kc2l3dHBuN1hGOWVn?=
 =?utf-8?B?dDJLeWY5d2todDNhdTAwcDlubFcxQWdoS0d5cnlBK1hSYm5Ib3FtV09SN3BY?=
 =?utf-8?B?dllkcC9FdjYyaEtXQ2xsaUtjNTAvS25kUHRUUnFjVnRaTERMUUQ4amlzYmJ1?=
 =?utf-8?B?K3V2YXU4ZTlVQ2IxM0lUdWJ3WXNiWWM3RnQ1TGdLR2JWMzMzV1ltY2FCdHQ3?=
 =?utf-8?B?eVpWZzNWSjJGQU9CUGpiTjcvQTdabHV0cXNrRUc2bUJncndFOTA4VWNrWTMz?=
 =?utf-8?B?RkFtVzBHeTJyQ0svd2thdVBpSithOERFNGJQVlFOL0tGa2NBNk9UelYwTU9F?=
 =?utf-8?B?Rzl1NnY0dy9QTS90SFhEZ1pOZ2k4Q2MrVExmaG1VT1haNjlsQzJqTk9zUlJM?=
 =?utf-8?B?TXl4Ujh2WXJVNEdRWFRQV1YwU0ZtWmlxM3ZVazVzQ0dDTGExZkdDNk1Cam55?=
 =?utf-8?B?ZDdqcnhWM0pyUlo0Zmc1S2RWT2MrZlJIMEFHSlhoTGRiTXNwY1BTY3hzdGlt?=
 =?utf-8?B?dS9MemMyREVvUHJ0cWtJQkd6dVRZNTRZREptTVFvMmdxdzBJbVczTHpldVJN?=
 =?utf-8?B?MTdUb0JEdk9XMzlWQVQ2VGN2ZXAzUVpDbjlYUmF0UDhkVExZYXlNaklDTjV6?=
 =?utf-8?B?ZHliVzhLSjYzZE9neXN1b3NUL1JyUENMbGVOVUlJNWE4ZS9aM1Z2N0dQRzVu?=
 =?utf-8?B?M1FVNnQ5b2JaZ1cvL0V2emIrVGErRjBjVnJ3NVp0S0g3aEdjbng0MmdydXdt?=
 =?utf-8?B?R2diZitpdzF4VWhkQ2tSLzhNRTh5OWhKejV6aFBRUExZcTRCSmRuTUUyaUFZ?=
 =?utf-8?B?Y1hYbDQ5bE94MmhaY25oNVFmN0dJVGQ5KzRPbU10UTVvejFRcGV6VlBCR0Jy?=
 =?utf-8?B?TnhNOGEwTDFUOHZBd3NXanArMWlMdXlGS1Vmb042VHNwY2o0ZHZWbDVMVHQx?=
 =?utf-8?B?RGN3S1FLZEtHWVlOTzF6b1lNL2RPaGZ5SzZqaEU4TTZDemhHVjEyQ09aU2Yv?=
 =?utf-8?B?bVlkU2g2WEhVYkFPa0tNWlh4UDRGNFYzNWN0QjQ2SEJRRGFhNzZYVkJmaDZB?=
 =?utf-8?B?WFBTSUlsM1h5UjZkdGRoUitwVnRMQWE5UWpXNzBUSkN4bCsyQk85dXdsNkJD?=
 =?utf-8?B?dXV0ZUgyYjhZQlVGSnFUbHJnM2dPMm9oSmY5eUtxMUR3Y3BMSGRCaVN4SzZp?=
 =?utf-8?B?WHdkbEV5YS93UGE1UXdJWkJSenhQQ3UvNWFoZ0V2eEJhTW9pV2pNUUdRdEtT?=
 =?utf-8?B?SitzbG15ZklCVDZtZ2Rxd0RLcFYxRkxwdjVCNEtkb0I1TXFVTGNudjBkU3cz?=
 =?utf-8?B?TVpMN29sTHlNRmp5Y3JpMlFuNmtDd2c1U2pFclovM1VKYzkrOHJ0czZqcHpy?=
 =?utf-8?Q?ca3PLtN35mt+vYKi/Ektqw839?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1ae520-514e-4572-097c-08dd31af4de0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 19:45:15.4289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCN6yzkKWhCbWOV6tuaSJW/q28K87NRy5S7DssOb/dtXb6sMfrUboXBd2ZEICcA8RM+kgoibiXtT6v3NyMQMsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
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



On 10/01/2025 19:37, Jay Cornwall wrote:
> On 1/10/2025 12:14, Six, Lancelot wrote:
> 
>>> If user shader issues S_SETVSKIP then this state will persist when
>>> executing the trap handler, causing vector instructions to be
>>> skipped.
>>>
>>> Restore VSKIP state before resuming the user shader.
>>
>> Hi,
>>
>> I agree with the patch, I just find the text above confusing.
>>
>> Reading this, I'd expect to see vskip to be resumed before s_rfe in 
>> the "non-save"
>> path.  However, that patch touches the save path (disable vskip as 
>> soon as MODE
>> has been saved) so the rest of the save procedure can work as 
>> expected.  VSKIP
>> will eventually be restored in the restore path when restoring MODE 
>> (no change
>> needed), which is done after any instruction that could have been 
>> impacted by
>> VSKIP has already been executed.
> 
> How about:
> 
> VSKIP state is already saved/restored through the MODE register.

Perfect, that works for me.

Thanks,
Lancelot.
