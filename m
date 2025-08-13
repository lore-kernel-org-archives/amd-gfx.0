Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF29CC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 14:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 877B010E733;
	Wed, 13 Aug 2025 14:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PfHddXY7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5C9C10E733
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 14:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBcxjXUwsdekvzxeslz20A3PCq/FRR3kMBKa9La4Geju69+lNPQGANxysUBABhgTEXUZRus6hjmJopWEDBxAY9qqZvSrpAwSdC71PNZMoNnZEIErOkKUOiEvM22aiDg16YXl6HM84jHSeXrsXOCb6oH2Kf5xvA0xr92gyGAnuAVSvGJKyDIKnR6mFvlnnk71FTWkbnZbYlwEygc0RrcBaKKZQ/3jpWaAJ0L024btZytLVpTkXcQ6Uj7mRYV5btDAKqLVbgVLXVVdCyMmzH8RcC4efiffOaSfHi9Li8/2RGz7bDXXeHgbwxpaiEKTSHxgmv8KPkLodvO4ICwppJjwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu5Fz99pYyWGUkga4frCbfb6BNG6Q50QD+39g5JTe38=;
 b=Z5W2a9bOqW4dBzPDm75z9ohAK+R3pbvUuN/gKWtIGxKy0UH8CjRMRC/sVLJttgph3WE5FS+ntWsLDJf/zV/uMKMOjGqraGkDE9K2aVHdjJr4A+IP0YaDSZCfTE/CGahVGXxD64UoaxL7BvwjP4XNfXyDWv/PkC7Z2qA55zXmidY8ztGTkxZZhlDEgJHU16x+RetHMmKwIAK6njZcPtdJjvTK6dfCN/iP5DL9/7rJDuyE1BV8eQiI6gUsnrkHV06gwm//eFfobZSZTNEUVAjbeYkli8cdm+hrXTmiuNzevNAy9PqnIgsQoyk/h7WUbKbX3fR/akMOfVxr4BvB1lnBlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu5Fz99pYyWGUkga4frCbfb6BNG6Q50QD+39g5JTe38=;
 b=PfHddXY77C/0Pk6Vj+BwpuBxmBqvSyLDB2vzGA8N2AfxiIGswuKcI5AUToKvsAQz4PAecElG2u0phe7Nj+I4dB9ahkGcv4iqMxz8CZsXvRQeBdYYKv9rqTsI4XVTrWOFd6fJ3JeTUSlW0z12OuGucyU6gtiPv5LSU942gBPPXYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Wed, 13 Aug
 2025 14:05:54 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 14:05:53 +0000
Message-ID: <a702925e-ac27-afc9-649f-72da8931475e@amd.com>
Date: Wed, 13 Aug 2025 19:35:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v2)
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: David Wu <davidwu2@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250812205816.1773798-1-alexander.deucher@amd.com>
 <c01c5980-70f5-474d-8173-c6be93b1c21c@amd.com>
 <CADnq5_NSvatcrG8qJL_be1e2XRqKiCZd0PdcWdDbxYxK6qMNug@mail.gmail.com>
 <bb315859-fd69-40a6-7efb-e9647261ea41@amd.com>
 <CADnq5_NLAyTtGoRP_xq4ntOHbXTF+u=yxCQ618dQkSiW2-c6=Q@mail.gmail.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <CADnq5_NLAyTtGoRP_xq4ntOHbXTF+u=yxCQ618dQkSiW2-c6=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::30) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b20b8f-17c8-48cb-6153-08ddda7283dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzk1YzRRK3c3cWdJOW1NWmp6Um1CR3lXQkh0a2t0S1FsT1VOTXRuZmN2ODN1?=
 =?utf-8?B?MjZIeVNlVTVLQ1F1QnlCMC96ZnN5aUhBQnNrNEtBTTRjUit6WC9oY0ZKUnBU?=
 =?utf-8?B?MDFFN0E1MHRURHZSUWx0Nkl2N0hjLzY0eEpaOFVGTkczdEcyL1VDZWswbUZC?=
 =?utf-8?B?TGx1VysvRVA3eW1XSFlSd0Vsc2lTTExINDZRY2dNNnIwT25NcHZGa3FXaXJO?=
 =?utf-8?B?RWcwaEpGWWoxUVA0RVRhU0RjUDk2TDc0M3ViVXBuVS9kNEQ5VVJKR2JPcURv?=
 =?utf-8?B?VEFKamw2N2ZjQ2pTcHZkVk9BUmtrTjNpZmZKa1lVd09yUnVXRVhoWjBoQW1o?=
 =?utf-8?B?YkJuUndEaTFjZ25nOEU5RWxGditiQlcwRURvNERFeWxpL09RZlZqdmRkZm11?=
 =?utf-8?B?M3hRQjZsNVNXUzJzeFBUWjluSTc4LzgwVzlFdEwwaVcyRjZRUi81OGVPNmhL?=
 =?utf-8?B?ejEvVkVXN05iTUtFYjJwUktUSmtFenJsQXg5RkZOWC9kczVGRlUxS1lXV3R1?=
 =?utf-8?B?U05iZnNsQTRENGxCYXUwTVRza3RhYlJrOWpwVWljUStYS3ZLb2VhZWg4N1NR?=
 =?utf-8?B?Vi9aZjYrR0RlWnc4RXdoY3N1aWRlTkUzdDgyZTE0QUdBQWFOZXlsdnBPUHB2?=
 =?utf-8?B?d2pKYjlNbUxKb2xJY0tVcDMwbko3Mk9FZXJ6cHBudUhyZGdTRWUzQ1hZUlhW?=
 =?utf-8?B?Vmc0clI0eTZSNW1LcGoxRUI1RXJMN1FKYTZteWNES2FXYjJyNHpLWDBheEE5?=
 =?utf-8?B?alg0SEk0UWdndVdWMnlnaEpZUXg1TFRueGhNOWZaRWxYV2tXUzBYa0gvOEl6?=
 =?utf-8?B?SEg0M3ZkZFhPMm1XNHM3UlJPNWtwdzdkbkhmbjhQc2M1dk5RYnFaYkxVUmUz?=
 =?utf-8?B?RlpkQ2ZsdERVV3ZaTkZGTUJ2MStHN1gzdjlXR25QT1lBcFdwVzZCUDd0WUJN?=
 =?utf-8?B?NE1Fd3dDYmQvYVlrcFp5OXppa2lBYTF3cXVJZFR1YU9SemtQZzM4dWFMN3VT?=
 =?utf-8?B?bVJtOE9pWmtNZW12MnpVWHltL1ZTYnNyVi9DeHBVckNML3pGdzdXa2tDOEVZ?=
 =?utf-8?B?eWh2TmE1UEIxd1lNVzJ5a0ErSDRRQURNOVlYZjF4UThiMElSQXU2V2tJVTF6?=
 =?utf-8?B?c1hEZ1VKTmRIcHVaM01ERExaTXQxR0RHanY1MytqeTVsZFJLU0ZqQThWRWl0?=
 =?utf-8?B?VThSVU5SdGZaUWFHSmNyS2c1RnVjUUxFYnNkcU5WMnljL0lJbGpDc0JuRXpK?=
 =?utf-8?B?eHUyMVRJTDVoRW9PcUZ2ZnFBOGVBakxsOUxLM1JTU01NZUR2Qm0rQXF1OTNt?=
 =?utf-8?B?RUJWSEZlYW5sZ05KNVlITGgxZXVWVjAvSk9QV0FXTCtSUkIzR2FadGdITmJM?=
 =?utf-8?B?dFFleit5YU03MUkxYzdRYnN5OHNrUmU0VlRlUE9SYkpqYktCRXBmeUhxZ2py?=
 =?utf-8?B?Y09RRDlEbTBwZXhuZGFxZE9EQ0xaRVY4QUZlK0ZIcDJ6NDNmcWlSOVhLcC9r?=
 =?utf-8?B?VU9rMFVPZ3lWZ2FWeG5FMXQvd1hDQWRXUW1VMmtIK25tMEFxdGxzaTBmejMv?=
 =?utf-8?B?MGhYcENPS25UYzZpUW5QRVNnUHpRQmE1b2RZcTFsMkhHNFY2TVdWa1FCdE56?=
 =?utf-8?B?dFdVb0pjelBZNXBBTElHeCtwa2F3Q20ydWFINEludi9PWlhwTTd6K2hSbkdv?=
 =?utf-8?B?d1JMVVdDbWpFdktyNi85RnRxQXdqOWZaUWZZd0ZybGtTR2JTMHZVQ3gwS0tD?=
 =?utf-8?B?UmlpV2tzdDJPZ0xhRXlwNUE0bnFWZjZQZDVSOHluYUFSMWFvbGRrRkw1anRK?=
 =?utf-8?B?cjdGRTJ4WDVxZTVVbTUxeGJ2bExYa3FCVTNyVTFiU25iQVBSelljeUVxRGov?=
 =?utf-8?B?OWp6TVh5N2lIYWlDbll4Qkd6WFJHeXBqODcySjF6VThyZGRsaWxsa29aNk80?=
 =?utf-8?Q?AltJJrK7q3Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0hoY2FoVHlJSXYzZldEVzcwT0puRWtHRmJhWHlsenREZXZtbStCbitLUEhR?=
 =?utf-8?B?QzVJZnhsbXN6ajNnbkNERTRqeTA1eU03UC9IcWtrNGRSejcwanFTV3FUTXpj?=
 =?utf-8?B?QVdLZTZUeUVERVJ2OVB1QUtFWUtwbHJFWWI2TnpnSzh0cmtSdEJhWlcwQjhw?=
 =?utf-8?B?aG80TGg4TXBuM3ZXUklsUHNPd0Fzb2dUSjF3Zmg3SXhaSlIxVVp3ODlaeCsw?=
 =?utf-8?B?bWNDMDVEdEU5cmQ3NGlmcGtGSjFBaU85TlRJSC9vMytBU1NyQlpwazhjLzNE?=
 =?utf-8?B?d1ZTM0RmQXNUUTd4UmNEYlRWZG91NHJLcGJWUmdRbDBwa3NqWWZheHFRNDZx?=
 =?utf-8?B?L2s4SGJkWW9sS2U5eGh3UHFzVmt5cUwyT2cxVGFNbUV0emIwUUtJeEJhbFN6?=
 =?utf-8?B?aWQ5MW5FM0RxRWhXeEhXS0xIYW5RUDU4anNlazRmbTVJdGdJRWpBWU9hdlc5?=
 =?utf-8?B?M3c5MW1nNXM3MlI4SlZydGRMb0twajZNK2ZLSEs1VTk4UzkvZjNmbStRbzlV?=
 =?utf-8?B?K2tUcFk5ZFFTaGhUY083ZnVWaEd1Z3BIczl3bFVMK21aeldWUXRMMnBPQmtv?=
 =?utf-8?B?ckhrV1lMamNlczc4VzM1TTNzL2ZhSGI4RmlVUWdYcVNsTlNFL25NakptcGp1?=
 =?utf-8?B?MGhjdndZVlUyNnVQbU1NYmV0R3hnRjBvVWEvMDFhdm5LQThMTExFaDFyeDUx?=
 =?utf-8?B?c3VFVlZXY3pJVHZtUkxSZ3hocVFhV3hJM1IwdWhYTmhoUGZjL3hiNDFMVzhH?=
 =?utf-8?B?SWhKNjNwNUtSVnpZUDNVT2VCdWtWbmVSZUd6TUppd3IydGowYU5kdSs1QTJ2?=
 =?utf-8?B?M1o2OEdUMzgvTFcrL3dNK3FmOG1IcGJGYVphRTRCMU81YTZBY2I4ajJSaTl0?=
 =?utf-8?B?czZFQ3F4U25NeXBiTXR2MUZaQ0N3ZXpTNlI2Nm1KNVBqYzliRDBkbTdSdFJt?=
 =?utf-8?B?QjhSVW5ZMEFDQWR2aENzeS9QVkt4VnVxOUVUOU9kRXQzZ0lCRUhLcmVpQjZD?=
 =?utf-8?B?blliUDU5ZWJmQXRpSnVRL0tYN1JlWVM2WGdmcERLSXc0OCs0Y1drak1ERGJt?=
 =?utf-8?B?TnlncWJCNjBkWlFlR0RQYlR4YlNBU3IzektSeEhJN2J1SFcxNG9IZWxRT28y?=
 =?utf-8?B?LzdLeWFYZU5RYXhJYmV2eUJvRnEvVnRHdWQvMTRxN1d0UmpBM1doRGFDa3NU?=
 =?utf-8?B?ZzdCY0sxR1BBTy9HUWJMVzArN3M4cmk2MnRDSXpnM2R2V0JuOU5IcDhZT0ll?=
 =?utf-8?B?bFhidjVKbGJmbkU5YjVrSHJod29sVnExSjdxZmNVU2RUNG5lL0hEZGIxRWhv?=
 =?utf-8?B?YklRQm9XOGphWVBBOG42UGtjY3VTOWpJaXY2eWwwMGQ0ejVXd2M4N1pPeDAr?=
 =?utf-8?B?TlhodEorMGZ2TnNlQUhGWXprNlVDK1M0UFplQThTcFhXUHo5TTc3eW5zZ0gx?=
 =?utf-8?B?SFhaOUxBUGxZRFNrUTkycE15YlRKZzBwS2NyM2p0NzRDV1FqV3ZwVlh1YUNK?=
 =?utf-8?B?QkE1YVpiOTFkU0kwcXhkbjBBQjR2UTNISVU1bUlGc3hQWTlqaWtkNzEzc2NZ?=
 =?utf-8?B?S0RMT3Naa2V2NElaN0NSWS91S1V2UnBvSjlHRkwrdVp1ZTVwZTY2Q2lqRUtu?=
 =?utf-8?B?bGY0VlZSN2wveDlKTkdGSDRtcmhkTHE5UnVsOE9vNCtHaUxPdW5Hd2hZV3Rr?=
 =?utf-8?B?YVdQbmVFRlB3RkhScmJ4TVpCbGc2a1A1N0l5QXhmTHZlRmFRNURSa0NYdjVL?=
 =?utf-8?B?bFJ2bEhsY0lla3BwSEpjeXh2b2ZLeGpmNWVCZ2xoV3FpcUxxZUs2RUZKampS?=
 =?utf-8?B?cnFReFUweEI0SjIwU3M1VHJ3T3ArWjlGbXFhOGcwNGhlRHdKTjZPWTExWjU2?=
 =?utf-8?B?TjYvaWk4cTRPV3JOT1FMVFNoTCtxQ21RR0Qrc1YxbGZiWGg5V2FFbDV3NElF?=
 =?utf-8?B?RGFvSGJFS1IwZ1FQbXV4OFBDMEU5TmU1dzZLK3V0bUhDN3piaCtkQnVYNERF?=
 =?utf-8?B?cXdlV3VDMlNlTjdEaU1XVUt4c0Ztdnl2cmdPU3JyR2VDL21GR21lU0pReEw3?=
 =?utf-8?B?RFJBR1plajJxNUE5TGNEM2Q1YlFoSkIvbWZDVkNWOEZhN2l0VUI2aGFDb201?=
 =?utf-8?Q?9MpP2n876zEczkuhUGbvRGqkd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b20b8f-17c8-48cb-6153-08ddda7283dc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:05:53.2896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNAuS+AVwBFf1Y2pomTX9pJKW0p3XsjMLD66jrLh8ymn+vv1JEX0AomlT7UBNw0sid6qdezEiS3Htr20mIgRXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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

Hi Alex,

On 8/13/2025 7:33 PM, Alex Deucher wrote:
> On Wed, Aug 13, 2025 at 9:55 AM Sundararaju, Sathishkumar
> <sathishkumar.sundararaju@amd.com> wrote:
>>
>> On 8/13/2025 7:15 PM, Alex Deucher wrote:
>>> On Tue, Aug 12, 2025 at 7:08 PM David Wu <davidwu2@amd.com> wrote:
>>>> Hi Alex,
>>>>
>>>> still have a concern - the fence or submission_cnt could increase in
>>>> begin_use but idle handler
>>>> has finished counting it (as 0) so it could also power off vcn.
>>> Ok, I think that is possible.  Will send an updated patch to handle
>>> that case as well.
>> cancel_delayed_work_sync(&vcn_inst->idle_work) at the top of begin_use
>> covers this situation.
>>
>> So there is no idle handler for this instance anymore after this call
>> completes, but the additional checks are okay to have.
> There are separate work handers for each instance.  What could happen
> is that the instance 0 work handler is running when begin_use() is
> running on instance 1.  The instance 1 begin_use() sees that the video
> profile is already enabled.  The instance 0 work handler sees that
> total_fences is 0 and disables the video profile because the fence for
> instance 1 has not been emitted yet.  It won't be emitted until after
> begin_use() completes.  The total_submission_cnt covers that period of
> time (between begin_ring and end_ring until the actual fence is
> emitted).

Ah! I get it now, thanks for clarifying, sorry I missed this.

Regards,

Sathish

>
> Alex
>
>> Regards,
>>
>> Sathish
>>
>>> Alex
>>>
>>>> David
>>>>
>>>> On 2025-08-12 16:58, Alex Deucher wrote:
>>>>> If there are multiple instances of the VCN running,
>>>>> we may end up switching the video profile while another
>>>>> instance is active because we only take into account
>>>>> the current instance's submissions.  Look at all
>>>>> outstanding fences for the video profile.
>>>>>
>>>>> v2: drop early exit in begin_use()
>>>>>
>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handling")
>>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 37 ++++++++++++-------------
>>>>>     1 file changed, 17 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> index 9a76e11d1c184..fd127e9461c89 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> @@ -415,19 +415,25 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>         struct amdgpu_vcn_inst *vcn_inst =
>>>>>                 container_of(work, struct amdgpu_vcn_inst, idle_work.work);
>>>>>         struct amdgpu_device *adev = vcn_inst->adev;
>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>> +     unsigned int total_fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>> +     unsigned int i, j;
>>>>>         int r = 0;
>>>>>
>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>>                 return;
>>>>>
>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>> -             fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>> +             struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
>>>>> +
>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>> +                     fence[i] += amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>>> +             total_fences += fence[i];
>>>>> +     }
>>>>>
>>>>>         /* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>>>>>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>>> +         !vcn_inst->using_unified_queue) {
>>>>>                 struct dpg_pause_state new_state;
>>>>>
>>>>>                 if (fence[i] ||
>>>>> @@ -436,18 +442,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>                 else
>>>>>                         new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>>>>>
>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>>>>>         }
>>>>>
>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>> -     fences += fence[i];
>>>>> -
>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>> +     if (!fence[vcn_inst->inst] && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>> +             /* This is specific to this instance */
>>>>>                 mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>                 vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>                 mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>                 mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>> +             /* This is global and depends on all VCN instances */
>>>>> +             if (adev->vcn.workload_profile_active && !total_fences) {
>>>>>                         r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>>>>>                                                             false);
>>>>>                         if (r)
>>>>> @@ -470,13 +475,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>>
>>>>>         cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>
>>>>> -     /* We can safely return early here because we've cancelled the
>>>>> -      * the delayed work so there is no one else to set it to false
>>>>> -      * and we don't care if someone else sets it to true.
>>>>> -      */
>>>>> -     if (adev->vcn.workload_profile_active)
>>>>> -             goto pg_lock;
>>>>> -
>>>>>         mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>         if (!adev->vcn.workload_profile_active) {
>>>>>                 r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>>>>> @@ -487,7 +485,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>>         }
>>>>>         mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>
>>>>> -pg_lock:
>>>>>         mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>         vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>>>>
