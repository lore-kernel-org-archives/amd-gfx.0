Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F0BD44C5D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 14:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C2A10E195;
	Thu, 15 Jan 2026 14:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S/vHck2M";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F2810E195
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 14:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkjI5dqoI8dRKMW++pn09yq+f0cjTOtWilzpC9HYEDcN5S90Btl3qz9zrAXFs/tx7s1oqDRH/8sEEzIt85AQRNkFiywp+wdL0mcVDfKSTcwRsAEE0CxZlpV8XzH0u3hvq1EjtsrJLW7yPS12zbbYeNmMlZlsS3n/B8VAOsYI6+vcdDZcZvBYWO7bh3pn59u8HufFTWXLq1BoRMyBViG4MHVpE3+J0hVwcUS8kTly4RHCNL+JkNhxFkNqgHv8KXwjbKPwyvGXGbHpcoYYUVMPccs4fZTowjIOFIhN5z8dbIL9EOGrOu+CMalK1tkuT76Meq753cNjifFnLAP0DMRBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5fmsJWYDoX60cIZQnFcahXrleGwQKsk3Wnuq+O8ydM=;
 b=XWkCGRGyzIfQrgdvyiwl+P7W9u4arEaFy5nfbj7QmV2eEhnz6NAh6DvKJoGAIlC+/uP2WGV6Oa/D1kOdbmswLSQFNYYzE+RLjrbpJslUC8M0vsFxMsEPMqm6N8CKcIDV0ZalxqZtwG0Svi5Zqp651hIW51kwuY6xPfv1JMDywfLH/qcboxQhelFXKCMG0wHXGklsvy7mN6zdhA5cA/LjlcSoYg/LFtH3fO79f8n4ephtqhioRz3yTv+QW4iIK+3xy1AqUmXf1aVNASi/mBFr5jG19HRQ+SsuOSCnvsm51yhc0JkrMNNXqNBDNdSwx6LN0uk6no/1zHRFIJtIS6F54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5fmsJWYDoX60cIZQnFcahXrleGwQKsk3Wnuq+O8ydM=;
 b=S/vHck2Mux2TKViEn1FKF04NpaVLClwXyL9pPc3Nsskz4o+TONg4uUJOFRzzUX+yEQgcThmbNbpNNByMYahM4fpJ2vThZtbjgKTPa4axU7yqZRmR7ms+1Y8HqEHv+LbSnZmT0jARenMjQGJowumDaRoX+kEc89dcwDlRQI8NTSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Thu, 15 Jan
 2026 14:54:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 14:54:11 +0000
Message-ID: <108860ca-b611-4715-a694-7b02da61da4e@amd.com>
Date: Thu, 15 Jan 2026 15:54:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/42] Improvements for IB handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
 <CADnq5_MJbjn8zD5O-sjL8vNk4eUD04jTXwkmS9Cwq3_WSajGqg@mail.gmail.com>
 <0288bbdf-880e-4149-ae0e-f2d2154cfbe0@amd.com>
 <CADnq5_M8-Qq14yYjoWJXgBRqQ42prGar1O6e8nxcEN5WNROTQw@mail.gmail.com>
 <CADnq5_PoHgp_Pf7EsV_bRwmh0Q7GuWfnEW-3Pp0gscT80VAnLg@mail.gmail.com>
 <6bbdb38b-75d0-4867-b4b6-afa5dc0b479e@amd.com>
 <CADnq5_Nm+E3trPt7LLUMBC697Upjnm6y46vdyXwBLxb_PHLxCQ@mail.gmail.com>
 <47105606-f0ea-4358-a7a7-8ff559d6d762@amd.com>
 <CADnq5_PHts+E6mVTXEaO=1f+U0YWsxdXBKhUB+Lb5g7pfcy1GA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PHts+E6mVTXEaO=1f+U0YWsxdXBKhUB+Lb5g7pfcy1GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:408:fd::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 5094af2c-4ca7-461e-c412-08de5445f19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWdYZERhaS9oSGFnTDlVY2xrZjZRbUpNa1NTd1ZRTDN1TmdxQm9qUFZKT1hK?=
 =?utf-8?B?dm53TGZ0a3ZhOTRHSG1lVHlhVEIyQ05MbkNkYndYYjRMKzFoeFB2UUxRd1hu?=
 =?utf-8?B?d3RpTlFLMUxvZHJ3UERVUld3N2ErV3VRQnYwWFVKclB2elMzNmMzek9yNzR0?=
 =?utf-8?B?MjdGVXBxdlhTWDYwRythZTMzODFwazkvcWJCMTMrcmh2c3BRcThoN3dtdXp1?=
 =?utf-8?B?VzRBZVMxMGpxSFpRd2w1MFpOWURBdTRHRzIyWFF2TkdEbXFUdWloSkJvQ2Fx?=
 =?utf-8?B?amhsMXA3eXlXWkV4bHY1SXQwa2wyeWlLNkticDhEeTZwbW5ldDhtVnVvZ0V1?=
 =?utf-8?B?RUlMMENMTDZFS0Y0L0o2YVVkZjRDeFpxUVdxTUxnVkVBSEZqQ2JEZHdrOGF1?=
 =?utf-8?B?UnFJMjZ0RkJUV2doSDhWU3NJNitvU3ZjQkFzWC9yeXZadVJiRDR4YWQrUmhY?=
 =?utf-8?B?cnpVWVN1dzNaaUlOZnFMeUM2anFPQjBhWjg3L1QwSzI4UW9kNXI5eS8xYWYy?=
 =?utf-8?B?V1pZT21venozRnJodk1GMkpOV3BPbEsvTENXRm5mdk9yQ0VFY05TOWVlU3V0?=
 =?utf-8?B?QmpkcmNTQnFoVWJ4NXE1NlYzWE0wZnR6eUN0MVIrWUVDb1AzaDdoK3l4bUh0?=
 =?utf-8?B?SmlIWlJ1V01hYVJFc1lRVjJROWhHRTk2UCtIRjN4TWJmU3oxOVhWSFRWUU41?=
 =?utf-8?B?QlluRkp5SFFYVng5MU1iVEpETGR2TEs4dlhjeTQzelg4WnJjNXBvRzlXTndJ?=
 =?utf-8?B?VmhEYjBFOFpQaVV4YVE2bG9HRmw0Kzd4RW5yYWxsOHFjWTJkenBvTlpGMitC?=
 =?utf-8?B?cTJxREQ5cnpML3RLWFN2T2lQTGE3WHVOaHFWZ3gxVldMWUY5TEI3ZDN1S3JB?=
 =?utf-8?B?M01kQU1XZ0ZjaWJqVE9DNnkraHBnTGgwYnVGUlRKQkk1RGlLSnRnVXE2MTBW?=
 =?utf-8?B?M0xvVkRIVXFDc3pqaitoUjRtNk5CUXBDVHFXN01yMHkzL0JXVEZCRUFrbXNr?=
 =?utf-8?B?S3FPTGsrdENLK0k1YVNJc3owOWpJYVhFcHdpUXQ3Uml1R3dSMDEzWGNjbDdy?=
 =?utf-8?B?VmtMZ0N6YTNhSjB0RVpnQ0N2bzI4TmxObWwzWitZOEpWUUtyTnVpdytlQmd6?=
 =?utf-8?B?L3dZK2l3eHdrelgrS0xreXlUT1hya1BrYlduVnp6RFVzcE5TTVhrVHNPQ0xp?=
 =?utf-8?B?SVpyVVVIRE80NnFQczR1UlFjUU52K3NGVXhCR2FoeUZFY3V2aGhwdUlKaWFj?=
 =?utf-8?B?aW4rdUpFdkFDbjFxbHRqU2M4SkZtMGZ2blNUR2lRUXhUcEhEUGhsdXIyM2RW?=
 =?utf-8?B?MGwranFjdG03V21NZWNBVTlDQnJRZENoMC94eFk1cVBTS1hzcWxySXFBa1RT?=
 =?utf-8?B?YTJ3dG5zTVVoWEE4NVgxa09PZERsb0pMYm03UXlPRTA1MHJZTFl3SWhDNlNL?=
 =?utf-8?B?UkZuRC95aTdjZjVCdHZTYitxa3IrWnd6NnBEMmtQb1IwY3pEU0trUUlyNTRx?=
 =?utf-8?B?aldXWTVGRUNZTk1jTlJ2SnhkN085QmMwbVhjeS9YMjV2ZWNCOXFkejFaSkJ2?=
 =?utf-8?B?S2I0d3B3aVFHT1llQmRwTEZteVF0aW91Y2pMWXIrSll3MlpXMG5qUEdYanhW?=
 =?utf-8?B?UDNQZ043bXNkaGhWbDcrM3hQN2lZRGRaYlFtY0U5enlRUklzYjNxNGJOSFZP?=
 =?utf-8?B?YnVQM3owYlI1YXpuNTJTODhjYTZJN25aOStlYkRwZWRVa2JLVHR6MExyeGdW?=
 =?utf-8?B?YVJBcVJGaGdoSUhNYm0zR0JOZWw3M01BbEFwc0gyVEpGYTlYZG8wRGNrZzBs?=
 =?utf-8?B?NFdkOVRUR0VIM2pqVW1rZ2llakVOTzI5cWcwTTF6OVBVTlEwK3hFSWNNSzFp?=
 =?utf-8?B?RzQ1VGxsWkdXSVNOaERYc3BaUGcvVjE1eGdwYmM2SDRXYUdYcjJJY1l5eEU0?=
 =?utf-8?B?OVIva3g3MDB5SnpNdkNYU3hqaU8yaTBzY3EzbEplWUprekR3MHhQbEFjeHRM?=
 =?utf-8?B?M3NreG13SFpOMzBuUE0waXdEOThMdTJNUGVaUjYxUndYM1NxaEFkT3AxL29n?=
 =?utf-8?B?YzBKU2pQVkhyZXQ5c0EwdVRpbXErNEMxeXJOVGxFN2t3YlN2WEE0LzdOR1Z0?=
 =?utf-8?Q?wtT8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1N6Zm54QkRCdmZDWERjeUZvNTJmM1RlTlFDWno4L0E0TUJjUEZMa2YxMC8r?=
 =?utf-8?B?K3M0Uk1lQllyemFMYWlMOUoxbEdLY3F4MlVhRU00cmcxZlJETXdmM1ZtbmJy?=
 =?utf-8?B?SWRnQTBNQU84YzIwUDFUVjZKMzUzMHpWNnMwY2pzQnJGQVFHY0l0ZUloSTJC?=
 =?utf-8?B?RmthTEs5b1dxZ0ZaZGJ1SjFSZmVsWU1KVThVajJ5M3l1OGJOSEpCeEx6Y0ZI?=
 =?utf-8?B?dXIwdnozLzZkT1ZVNW5NUTRYb2h5TnhLMXE1Z2dBelBzMUlnUG5zNE91dDNo?=
 =?utf-8?B?ZDMzbkNLWFF5dEhneVpDN2tMSDdCeDlBRC9VTkxLZFVaL0FOSnpWRFNZMEtu?=
 =?utf-8?B?aFhxU2lJaEU5bGdndGdEZEliTU1uOGdZTWhVVytRMzRoUVE2WlJlaC9CN0w0?=
 =?utf-8?B?MmN3Q1NmSDl6dWVzK3NMYko5TEwxMHBPQy9xZFFkVzdraXIzQlVxVlJrZVJB?=
 =?utf-8?B?M09IT2MxTVdmNVBzVWxJNjlmWm5tUlFua1d2d2RNVU81dFI3TDB3bUxoazR5?=
 =?utf-8?B?WUFtdDVQSGlJb1dkWElZcGw3aTkveEdsalluWXQwNWxCa0ZVbGs0NkpDTEpl?=
 =?utf-8?B?Wm9VS0p6bEg5Uzk2TTFSSGJTaGVHaURwZVM3clBrblRxTW5KWXJkUkZoaU4y?=
 =?utf-8?B?WjZ6Y3VrWTRQekQyandGR1l6NjF3QTFENVFkZFgzdWxEV1BZcFJHWjZZU2c0?=
 =?utf-8?B?MDlGVGI5djJrbXhvdEJvRnZuaVVpaVVSYVoxcnM1UE9yZGl1SHNwYmhiV1o5?=
 =?utf-8?B?eDNJLytTMlhCTFhVci9rQ3NUN3RRSVhYUm5MUTJWcUNMVFk3enExd1FTWkZz?=
 =?utf-8?B?RlV4aW9SYzhseDN0Tk8yems2UXNGSjhrZzFUd1A0WEJyZW5RNUhTaU02cWFF?=
 =?utf-8?B?blo0K0toUTZZNGJvb1psdmI5WjN3UkliSm9zT0k3NU5HZDgzV2hrbWxkWlVj?=
 =?utf-8?B?WDgvNE5mdG16bTFpQzhmUURLQ0xkcjlEY2pRcjFNb3c5ckRSSXg5SGlPay9P?=
 =?utf-8?B?c091aFpCWFUxZC9QMG9pV1BCYUNGNjM5SE5XR1lZUm1oVGZPUlppOGVNaEpk?=
 =?utf-8?B?akxBSjc0Ym1Ramloa3ExdDZna3NsT1l6UnpwY3VFV05sTDhUUUxiRDFVMCsr?=
 =?utf-8?B?QWlaRVp2bTJSeUttL29IN1VvMzhKdnNxRys2clZEejUxRFJGUlpxd0xFV25m?=
 =?utf-8?B?VXhrRmJ4Y3JrNENNRFBCbTRNcDV5V3h0THFFcGpnT2dNUmlaMUZLNGt6Wldk?=
 =?utf-8?B?UXltWDRwNW9adkJEV0oyVGc0MjJ0WHExQzlsZ0RKVFpmdjhQTEFnc21wcWh4?=
 =?utf-8?B?VkE4N1h3MDBvQ2FwNUwzRGZlTjkrY0Exd2ZjRnh4ZU42MWNCVUZraUJyZm5p?=
 =?utf-8?B?ZklIME1FcldjMEZmR25sWkJGc252VW9zY0ZvbGx1bjNBbWNQLzEremtBSFhq?=
 =?utf-8?B?SnhqWjM0QkU5OXNzL3BXNnk5UVJ5cTlraHF2QTZORFlPNUJOYlFuTmRZd01o?=
 =?utf-8?B?TGFPSUM5QkYvMWxLaFlZSm9WbThkRTljbHhpbWN1Yyt0azVGZzZnMXZCUytH?=
 =?utf-8?B?Y3FKbFhaank1Q1VVS3IvQVp6enV2QTRVeVNQaWQ3Q1V4bFlrV2lOendIT1J1?=
 =?utf-8?B?OHM2YVZjZVVQSi80VU90c0xPUG5ubWhiSWN3VCtCUVJJTFpCY2dLNkdtd3Ri?=
 =?utf-8?B?WTNxOXhIUXY0b1BNQWhHK2k5V3lxY2dKZFE0SEl2MHBHQmZDNzU0ZG5yQmFH?=
 =?utf-8?B?REVFM1ViamoxOU1nMWhUL0E2V0YwUG5kS3pTNlpVTFMwV0d3TVFMVmpCdDVR?=
 =?utf-8?B?TkUxV0NXcW1MWVFiNmJucVdPQVRld2xXQUVTMUhtNGVWRUtiR1Q2M09Ya3lz?=
 =?utf-8?B?WkVFbHhGNUpNTng0d2JLY0xTVXBxRVN5ejBiQkhJaHRUZ1FEM2ZSSnNrUlB2?=
 =?utf-8?B?THhHaFNZVjg4NXZUaTVoeC9CT2dqZDhYV0pYUWVTMXlweXVPUmZCYy8wbGFH?=
 =?utf-8?B?TUFiZlp4UUl6VVBlSkVNS2ZLdS9jUE12akROd1BNWWJ2N01OVG1nT3NkQXhp?=
 =?utf-8?B?Z0YzYnBOWWdaeTR1bmcrbTAxSTdsWWY0bEJsSENxa00xUFBUenpackQxNVR2?=
 =?utf-8?B?d3Zwc3ZTenBOcHoxWGZjTENUeGx2bEV3czlDdUo2KytwTFA4VmtibSt2c3lu?=
 =?utf-8?B?Nzl1ck5KWGx4K2M0QWRJUjFqWWhlNms3VHE5SHZDbWdSY2xXenpMZUxVbGg0?=
 =?utf-8?B?UHZpeW10MGFBVmhrK0pxdGFUSTE1cGxRQlZOazZId3NuU2d3ZURnaXZZNXRi?=
 =?utf-8?Q?XmL93vcJ9SnpejUvGn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5094af2c-4ca7-461e-c412-08de5445f19e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 14:54:11.8008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yI9RDfojP9+31ggSXw7HaXBYu2foYtYM+w1+QalAUdwzf2RAIVkURURIuz0YIGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
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

On 1/15/26 15:08, Alex Deucher wrote:
>>>
>>> Explicit re-emit is the only way this can easily work correctly.  We
>>> save the ring state and and job state in the job and then we replay
>>> the state and re-emit a proper coherent packet stream after the reset.
>>> When we re-emit, we update the offsets as appropriate so that the
>>> logic works properly as you replay the job stream.  You can skip the
>>> IBs for the timedout context, but as long as the rest of the logic is
>>> there, everything works.  Saving and restoring the opaque ring
>>> contents is much harder because you need to either save a bunch of
>>> pointers or try and determine which offsets to patch, etc.
>>
>> Or you tell the HW to continue at the place you stopped excuting and before the reset and use the conditional execute all jobs are wrapped up in anyway to determine if they should execute or not or overwrite the commands with NOPs when for engines who don't use the conditional execute.
>>
> 
> Not all rings retain the contents of the ring after a reset

In that case I think we should not re-emit the work at all.

For example even if VRAM is not lost after a GPU reset the remaining state (VM etc..) is gone and can't be restored easily as far as I see.

We should absolutely not re-emit prending jobs in that case. It's basically just jepardy if that works or not.

> or may not
> be able to start at arbitrary ring ptr locations.

Every engine can do that, we just have to insert NOPs until you end up at the specific location.

> Plus only gfx and
> compute have conditional execution support.  For everything else you
> need to adjust the packet stream.

That is harmless, just overwrite with NOPs. That's certainly something all rings can do.

>> Re-emitting the command stream would only be necessary if we need to change the commands in anyway, and even if we would need to do that then I would say that we should not emit the commands again at all.
>>
> 
> The only case where we need to mess with anything is to support the
> set_q stuff and that is only supported on one gfx11 chip specifically
> for SR-IOV.
> 
>> I have patches in the pipeline to remove the job object from the reset path, so that we can free it up directly after submission again and completely solve all the lifetime issues we had with that.
>>
> 
> I don't really see any lifetime issues with the job after we fix the
> whole sched stop/start stuff.

It's not only the job object itself, but also all objects it eventually points to.

For example job->vm is invalid after you initially emitted the job and exactly that has been caused issues tons of times.

> Moreover, having the job around (or we
> could hang the state on the fence, but that is less clean because
> there are potentially two fences per job that you need to keep track
> of that share common state) makes it much easier to re-emit the packet
> stream after a reset.  It's a lot easier to just call the emit
> functions on a clean ring than to deal with opaque ring contents.
> Depending on the ring you end up needing to keep lots of pointers to
> mark fences and job boundaries.  Then if you have to re-emit the same
> job multiple times, you have to re-adjust all of the pointers, plus
> deal with skipping the IBs while still emitting the fences.

And exactly that is what I'm trying to prevent. Emitting jobs multiple times was an extremely bad idea.

I can't count how many hours we have spend over the last 10 years just to try to get that working and we still have the same problems we had at the beginning.

So I absolutely see no change that this will change.

Christian.

> 
> Alex
> 
>> Re-emitting completely breaks that again.
>>
>> Christian.
>>
>>>
>>> Alex
>>>
>>>> Long story short that is seriously not going to work. So absolutely clear NAK from my side to this approach.
>>>>
>>>> What we could do to avoid problems and patching pointers in the command stream is to emit only the fence signaling for skipped jobs and fill everything else with NOPs.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>  At that point the ring has the
>>>>> same state it had before the queue was reset and the state gets
>>>>> updated in the ring as the IBs are reemitted.
>>>>>
>>>>> That's it.  The only other state dependent on the ring was the seq
>>>>> number to wait on for pipeline sync and I fixed that by making it
>>>>> explicit.
>>>>>
>>>>> Alex
>>>>>
>>>>>>>
>>>>>>>> If the relevant state is
>>>>>>>> stored in the job, you can re-emit it and get the same ring state each
>>>>>>>> time.
>>>>>>>
>>>>>>> No, you can't. Background is that the relevant state is not job dependent, but inter job dependent.
>>>>>>>
>>>>>>> In other words it doesn't depend on what job is executing now but rather which one was executed right before that one.
>>>>>>>
>>>>>>> Or even worse in the case of the set_q_mode packet on the job dependent after the one you want to execute.
>>>>>>>
>>>>>>> I can absolutely not see how stuff like that should work with re-submission.
>>>>>>
>>>>>> All you need to do is save the state that was used to emit the packets
>>>>>> in the original submission.
>>>>>>
>>>>>>>
>>>>>>>> If you end up with multiple queue resets in a row, it gets
>>>>>>>> really complex to try and save and restore opaque ring contents.  By
>>>>>>>> the time you fix up the state tracking to handle that, you end up
>>>>>>>> pretty close to this solution.
>>>>>>>
>>>>>>> Not even remotely, you have tons of state we would need to save and restore and a lot of that is outside of the job.
>>>>>>>
>>>>>>> Updating a few fence pointers on re-submission is absolutely trivial compared to that.
>>>>>>
>>>>>> It's not that easy.  If you want to just emit the fences for bad
>>>>>> contexts rather than the whole IB stream, you can also potentially
>>>>>> mess up the ring state.  You'd end up needing a pile of pointers that
>>>>>> need to be recalculated on every reset to try and remit the
>>>>>> appropriate state again.  This approach also paves the way for
>>>>>> re-emitting state for all queues after adapter reset when VRAM is not
>>>>>> lost.
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Alex
>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>> On 1/8/26 15:48, Alex Deucher wrote:
>>>>>>>>>> This set contains a number of bug fixes and cleanups for
>>>>>>>>>> IB handling that I worked on over the holidays.
>>>>>>>>>>
>>>>>>>>>> Patches 1-2:
>>>>>>>>>> Simple bug fixes.
>>>>>>>>>>
>>>>>>>>>> Patches 3-26:
>>>>>>>>>> Removes the direct submit path for IBs and requires
>>>>>>>>>> that all IB submissions use a job structure.  This
>>>>>>>>>> greatly simplifies the IB submission code.
>>>>>>>>>>
>>>>>>>>>> Patches 27-42:
>>>>>>>>>> Split IB state setup and ring emission.  This keeps all
>>>>>>>>>> of the IB state in the job.  This greatly simplifies
>>>>>>>>>> re-emission of non-timed-out jobs after a ring reset and
>>>>>>>>>> allows for re-emission multiple times if multiple resets
>>>>>>>>>> happen in a row.  It also properly handles the dma fence
>>>>>>>>>> error handling for timedout jobs with adapter resets.
>>>>>>>>>>
>>>>>>>>>> Alex Deucher (42):
>>>>>>>>>>   drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
>>>>>>>>>>   drm/amdgpu: fix error handling in ib_schedule()
>>>>>>>>>>   drm/amdgpu: add new job ids
>>>>>>>>>>   drm/amdgpu/vpe: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/gfx6: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/gfx7: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/gfx8: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/gfx9: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/gfx9.4.2: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/gfx9.4.3: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/gfx10: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/gfx11: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/gfx12: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/gfx12.1: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/si_dma: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/cik_sdma: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/sdma2.4: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/sdma3: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/sdma4: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/sdma4.4.2: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/sdma5: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/sdma5.2: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/sdma6: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/sdma7: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu/sdma7.1: switch to using job for IBs
>>>>>>>>>>   drm/amdgpu: require a job to schedule an IB
>>>>>>>>>>   drm/amdgpu: mark fences with errors before ring reset
>>>>>>>>>>   drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
>>>>>>>>>>   drm/amdgpu: don't call drm_sched_stop/start() in asic reset
>>>>>>>>>>   drm/amdgpu: drop drm_sched_increase_karma()
>>>>>>>>>>   drm/amdgpu: plumb timedout fence through to force completion
>>>>>>>>>>   drm/amdgpu: change function signature for emit_pipeline_sync()
>>>>>>>>>>   drm/amdgpu: drop extra parameter for vm_flush
>>>>>>>>>>   drm/amdgpu: move need_ctx_switch into amdgpu_job
>>>>>>>>>>   drm/amdgpu: store vm flush state in amdgpu_job
>>>>>>>>>>   drm/amdgpu: split fence init and emit logic
>>>>>>>>>>   drm/amdgpu: split vm flush and vm flush emit logic
>>>>>>>>>>   drm/amdgpu: split ib schedule and ib emit logic
>>>>>>>>>>   drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
>>>>>>>>>>   drm/amdgpu: add an all_instance_rings_reset ring flag
>>>>>>>>>>   drm/amdgpu: rework reset reemit handling
>>>>>>>>>>   drm/amdgpu: simplify per queue reset code
>>>>>>>>>>
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 289 ++++++++++----------
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  40 ++-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  13 +
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  67 -----
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  37 +--
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  21 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 +++++-----
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 +++++-----
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   6 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 ++--
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
>>>>>>>>>>  54 files changed, 952 insertions(+), 966 deletions(-)
>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>
>>

