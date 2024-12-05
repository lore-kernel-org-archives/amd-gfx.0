Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17731E7716D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 04:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B3510ED98;
	Thu,  5 Dec 2024 04:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vLKwZZiG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F070F10ED98
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 04:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH2NCBWs2470evzGaLQ1Cd/HEAppDn0RfFbMFiKZYiU4ZdT+vjAPL7vSVoboZq81eslkxthpI4g/FbkmLeF9hrPYdgmUHI9DxmwNsXZ4n3+zb8A0ZMqvVMhcAKWkF36zDnzu5TbzXpqY5H8BE05N7hYrnebQLfj4bVOFw8KJuC0TsDBS39swvPBsT/AjiCQF0WKjfNKzDYAvbuvPumtJvqthG8ao4l1VTsCOGSh0IlptHXD02luHflIxIewkQ4FT/o8qk5maadYcEadyGGEc7unQgrhZMKP2crq1O3Ts4/7TLnpXZsyXmuWKQcbevtRPOVlG0vX7Zt4XOHmXkP5hdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOBDZXiWJ7PzUqxYexemMBlR6eFunFDWv2TxwsNQ6vc=;
 b=P4Z6ilgxNrfXut1+U+FK+fb+v9atHgzJ/R+fdb/3nWg5ycKACwEbm/rPin9Lci5/ZrFzgrxeZNwJSVXjOZT94Qiu81mD9GRVuYqtjLNZ2K/baeHWz7SzCxwjFUZ2FuowIp0MjizoOkQNULMWu81ThiKushpa9V9NY2MTDDXS/XN21ZnAj+nJAFDi8/6RucxNmpwmNm7lIrlhXF3BRm+nRsfRo6syIVarTrx751LokE20BnRTE/mZUxn0iJpzpcIl7CTIqzrmHD+kBrpd7YLpf+hD6n9/hsyB4wZGGImLw3w39y9D8WCI7UIJ5unr7wTSHhuzILXIlZRRQ0iEopqWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOBDZXiWJ7PzUqxYexemMBlR6eFunFDWv2TxwsNQ6vc=;
 b=vLKwZZiGM0ulwlU2gsaP2pryGkN/Lc1BN6E+B6f7ktogGMlekZEajbpCUc0E+r4FiojK0AofmwDY2PQYtX4eUN7ryqMTRDRhp4AUxY0hAgJ+7r7DChgbmM7F2454yr3HbT2YbCQLaRsbo1iZcx2KF4uAfySHSvXXZT9s9ewAGOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.12; Thu, 5 Dec 2024 04:30:39 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 04:30:38 +0000
Message-ID: <41723677-ff2c-4816-af66-b43c7397e9f1@amd.com>
Date: Thu, 5 Dec 2024 10:00:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
To: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20241203181403.23515-1-mario.limonciello@amd.com>
 <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
 <c5a7f27c-c676-4e10-83ba-393a4df06ada@amd.com>
 <20d00e76-7ce4-42d0-a968-d7adae616984@amd.com>
 <CADnq5_MPEZA2CYfFnG3u--bDeD3eQyZO6igCQQqHEp-BJNwy-g@mail.gmail.com>
 <2062652c-16f6-4e06-b3d7-73ef6a684aaa@amd.com>
 <CADnq5_MD0wexpOc+mGoXkHMHDv5BxybR+tyowedwxg7vvp6mQg@mail.gmail.com>
 <9f85de41-5574-4e83-b5ed-1640e45e90e9@amd.com>
 <CADnq5_PvErRnCQp-oTR1Qw46H6vo9BuWzH76ERqQ5XDzA1dkoQ@mail.gmail.com>
 <176abc17-3f0e-4b9d-8043-0674a9cb6f7a@amd.com>
 <84b8f486-5afb-495c-81df-05c852212507@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <84b8f486-5afb-495c-81df-05c852212507@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: df511d95-8b57-45e7-e45b-08dd14e591f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEdPbGtkR3ZhbDV6bGY5d3QvK0hUREluQnQ5T3krc0tydlo1bFF5V1hqVnd6?=
 =?utf-8?B?Z0llQnNZU3p0MWRySFZmdFJqUzREQVFuajZKVmx3M1BHSzNibWkxZHV1cFNq?=
 =?utf-8?B?cEJZQXpkcG8vb3BhenVJcm0zbHg1RFlpNVdUNnloZkhTNXFjQXFabi9ySmFF?=
 =?utf-8?B?T0poVURPekRFWitjTnN1NkRpeUYvMkpBUWIwMTV2TFYxSllvWjRVYXBna3JO?=
 =?utf-8?B?OTFuWE9GdkR6cUM4cHVmSHdEQldLenp6K016NHlvVmNER2IrMkVuSUU2MGor?=
 =?utf-8?B?RUdaTWMzTklNSGlnZzJCREhGSkRUdVNGYlBiVlFaaVcvU3lZK1NHRE4veEpE?=
 =?utf-8?B?bnBkc093MWxsemVBZ3lyVG0zc1BsZnVHdDRRZEd3SVBHdi9xbTR1YXp3MUI5?=
 =?utf-8?B?K1pabm5OczNDdVFIQjUvTHV2RUVKbXBCa0thY1RtU2xFZWlOSnFNUjBWNlRT?=
 =?utf-8?B?THZjVnFlZ2ZweEkxcVludW9yL1cxNW1hejI2YjYxcCtvQUVHYU1vT2RiQzU1?=
 =?utf-8?B?TFVJcmVMM09HR25VWEZVRGxDdmZzaCtsQlFJNVZ5M2k3dDNtdlg0KzRWNitM?=
 =?utf-8?B?RC9BUXlFTkw3YmlsUnNhWHlQZkpEQVZQa1RvSnBTZUszQzVaOXoreDIrdzBz?=
 =?utf-8?B?KzBIcWVHcGlJZjR5aWVscVozL1BtRCtUUEVRa01JcWh4Rlh3WjltaHErc2hB?=
 =?utf-8?B?NTRtTFFTbG50eVphMGd6akJ1cUdUT0lGWnZ2RHFLRHB3ek94dVg5MTR6UTFH?=
 =?utf-8?B?UVJqRU9QOWhqTzFibEZTdU9jSXVpL0liM3J6TTFlMjI3QjBqL0FoY2pIdXZI?=
 =?utf-8?B?V0RqYnlzU3hqbkJMT1p3RXFEV1BZRUlxN2EyTFB3Z2lzVHVhbC9iMjl5MG02?=
 =?utf-8?B?NkhpWEFHYXd1MHlJZjZreTNkbUlZaEE2SWNNaXdMUElaZE1Rc3o0N3JCeXJH?=
 =?utf-8?B?S0UwdE80VG5CK2hFRGtjZDBLT0lSc25OM05ndFA5YTNZMTBTUmRhVGllenRz?=
 =?utf-8?B?Y1J3OUdlZWRrZG1XNG5ncFpoNlJMRFBuaHlVVHJER3kwMnNub25vM3k3NWVn?=
 =?utf-8?B?UG0rM1IrVzBmS2RuNEpFcm83dG5XZk4rQ1ZDcEJGZzhjSGlVT29qZXV3a2xG?=
 =?utf-8?B?NUgvblhBMHo4TXdNYTN4Nnh3c3BSWXptWTRZNGNjY3JxZ2h4NFovUkVjYUk0?=
 =?utf-8?B?T3JyV2ZVbW5pY20wb2x0Z2tSc1JmYlUwLysrejhFcGRmcGhaVUFSSVFJMFE0?=
 =?utf-8?B?aUJVckRNd0x1Y25TcFBraUlGc3hLRUMvZk5ZUVdMWGJpay9SY04wQWs1bGxU?=
 =?utf-8?B?SUltZHZOV1V0VjZ2UnJTWFRLUDNCWm5CSEFKQm1WV3B6OWM1ODlybkdPa25S?=
 =?utf-8?B?aVdheXJqZ3ZvRlJvN0JlNEpCNndNdjdFZTMrS2NJNXpZNG1PRDB4dm02eHlv?=
 =?utf-8?B?VFVpbmQ3SnNjVjRZMDAzd25wYTNqL25JK1FqSmphQnpGRVR5TzQxZlo2SmZh?=
 =?utf-8?B?NW9KSTd1YUxGcndKeVZ4UzVUN1pQTnh1ZVE2MUp5bXd3ZFlydGl6V1dtS1dZ?=
 =?utf-8?B?SXlGUTZxZExkbE5iaEM3RlZYS0g2enBNYmoyYm10bG8valQ0YWxZN2pqR3p4?=
 =?utf-8?B?Syt0eE8vc0tONkZ3N2g0S2RqY1pUR0REbkVaR2k5T1RIM1o0SkU2aVRsSDg5?=
 =?utf-8?B?bGFLY3dqRWFMTzhXOXQxcWJoN0hmK0NoWGRUc01oeG1vZWM2QlFOSkNseWx3?=
 =?utf-8?B?SHdNQU9nY3BQbTRIUnpsN216MWhGZkVYUlVub0JqQWkyQmV5TTh5RUozS2Ry?=
 =?utf-8?B?bjVVdDB4UVl5NDRUNkw3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxxaDJvd0FMTXJrR1hid2s1Uko2WmxLUlNhTCsybEdiWFR5bzdMbG5pV2NC?=
 =?utf-8?B?STlnQjJNRjcwR2liK005dkN0MjBWNFpLcGpGSk5HazYxdXZTQ2JaV0pDT29O?=
 =?utf-8?B?RlZBdGdFUDFWNlRMQW9IT0I5RERTb0xXU0JLOTlwN2lyNGNBQ1ozd3ZRVmFt?=
 =?utf-8?B?czJ5ZFUvV2xVYUlvY2NBNzRBbjZ5S09lTWpJK21VKytXbklaSm5yTSs4d2d2?=
 =?utf-8?B?VER6cU4wck0vMDZOclZwM1lBZDNLRHEra3hDa3pNVlB1NWxCQjZQc0hIL3ZB?=
 =?utf-8?B?SXBuaXIrV2l5Yms2TGRwVnVLRFMrbkduMU1GaWF0Z2s3dmR5dlJwYi9TZHJ0?=
 =?utf-8?B?Vm1YTTZCbisvRm52WFZLZEJXOHc1UUNDMllPRW5DdnVVMDZDTG16S01kL0ZY?=
 =?utf-8?B?KzBPUStvVnNvTlh0QzQ4MU9YMVVzcjNQK3VGdkZsY0xQUzNray9mRU55elFF?=
 =?utf-8?B?ZklDUEZTSHcxZ0pxTHRpVDlBZzV3ZVNBakozUHNpS2wzOVRLS09lcnBFS0pU?=
 =?utf-8?B?U3NnUWhtS1lRMklQS1VFckZ2WGFPQjY0VUkzWkV3UUl3aWVMZWl5RTJkNzdF?=
 =?utf-8?B?OFdSbTRURnB2Tk9aVG9kQmhrc0RSV2EwVituQWNBNXBXMS9LMzIrL3J0UEtI?=
 =?utf-8?B?ai8xeEZid0tVdkxsMlhRbVROazhZWkZ4RXEvSHFGZFA3Mnc1RUdkbU9QVVlr?=
 =?utf-8?B?RHgvSDU0cHl5dG1LQ1EzT2taK2YveFM2VGV2TzlabGczQk8zMzFJSHRiejZt?=
 =?utf-8?B?UFNOeTloaE12SEliMEdobEpHdGt1NG1DTEo1RDd4Nk8vQ1ZCQjg0Y25ya3ps?=
 =?utf-8?B?YnhEenpGZDZ5NTF6OU83Wm9OS1Q2akV6Z2VoYzI4WE1rRVIxaHRSR0FPY3o4?=
 =?utf-8?B?QmtPT3dqbjNveUtOWXhkVmwzR2xZM1hsRXlGYXpyaUEzanVjUjFUTUl4OXh1?=
 =?utf-8?B?N2JwNFZ1MXJTK243Y0N1SVAyZGFYY05ETjdsNklqdHkwc3FZOWlYOWV6Z1hk?=
 =?utf-8?B?akRtSm5GaWFzVS9BMnBhdWo3UjZIMjJhbHZZOFZKSEJ3SStYMHk3QVFzV2JJ?=
 =?utf-8?B?OWVpUUtEVWs0ajdVVW9VVWcxZFM0bm9xaHdjY0RwQkp5Z29KQXVKK2lkZHlE?=
 =?utf-8?B?MXJpVU56ZnRyQXdRTTNCUndxQ2JYTVZjUFp0Q3MxWWs4cnROMGt2cXlVTHE0?=
 =?utf-8?B?WU8zUStZOEU4bXJyeFo4UkFzWnFrNlpkS1RaVFdia3Q4Zk1LKzBmK09vcUFJ?=
 =?utf-8?B?QkJuQlJ1OElUdytMc3BGWmVIRWx3OEVrc3pOR25haHh5TDk0cmF2QWd6K3dP?=
 =?utf-8?B?aWxqN0VxbkdwUFlNMUhTWTFlRkNBUnRpSW9Ockt6ZzNWaXR1ODB0YXNJTmM2?=
 =?utf-8?B?Q0hITU41ZDdOL0NOaFdSRldVYUlLcTdGNGNVZDRac05idXUybUw3akMrVkEw?=
 =?utf-8?B?MExpdW1ydmZ5Z3RnZFFUSXYyTDR5QnNUcHlTU1J6dGd1eUZPSWh3L2p1Nmpr?=
 =?utf-8?B?UmVSQ09QUktaZnludFJCelM1M21SVkhKMnV2TDF0RlBxdkkwZllja3R3K3U1?=
 =?utf-8?B?Yi91QVJPVWNlS0hMVUFuc0dTUWsxNVBZeUVtc3FiSi9GN1QxZmZzeWIvWW5P?=
 =?utf-8?B?dCtJa0JneXJUSkVYZEowd21ndHplaEZQM0c3VzEwZThYS0F2V2w1aXB4MXM4?=
 =?utf-8?B?WVhZc3ZqM1RBV1pRV3VuSHVkS0ZIR3lXUXNuUlMzQ3dEVFBKVFkyWE9xSTFC?=
 =?utf-8?B?UEh5a014ekJvNFBUV012RUFwT3BkTmVaQ2lnRURDajZzTm0zcUF0Z0hGNFJY?=
 =?utf-8?B?SnhQbkg4VElhbVl4V3puQU1MU3E4VG4xeVpqbnNuWnF4Ynp5ZllOcnZSamhX?=
 =?utf-8?B?MTI5eDc5Vk4xME9iL3NsYlRtZTVodGI2dEEvbzhIS2xScHFUazM1c0JDZ2dT?=
 =?utf-8?B?WU5KaTVlV3FHWmN2bXZ0UFpGL1p3dnUyVi85N0hUUEJsWTVvQ3N3Ry9DaDJk?=
 =?utf-8?B?ZXp2S0hYMk1wbEIwSFBEWGYxVjNkM3M3MUZNT3kzeGZ6M3A2M1dUTVY1dXoz?=
 =?utf-8?B?NGsvL0o2VFFnazhwSmZDK0JYbkpxekpOa2w1bml6ZWxkQVZ0Tk02N3VnTkd1?=
 =?utf-8?Q?qVPESmmywazChmvJQ7KAkC+mx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df511d95-8b57-45e7-e45b-08dd14e591f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 04:30:38.8474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qhWxYEpjx5HO8mfDWPbhGmN2k+HWHiZgP8sxS+mOAEKfHlSVM6TLDXWaOBBKXJM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
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



On 12/5/2024 9:36 AM, Mario Limonciello wrote:
> On 12/4/2024 21:59, Lazar, Lijo wrote:
>>
>>
>> On 12/4/2024 10:15 PM, Alex Deucher wrote:
>>> On Wed, Dec 4, 2024 at 11:18 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/4/2024 9:30 PM, Alex Deucher wrote:
>>>>> On Wed, Dec 4, 2024 at 10:56 AM Lazar, Lijo <lijo.lazar@amd.com>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 12/4/2024 7:51 PM, Alex Deucher wrote:
>>>>>>> On Wed, Dec 4, 2024 at 12:47 AM Lazar, Lijo <lijo.lazar@amd.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12/4/2024 10:44 AM, Mario Limonciello wrote:
>>>>>>>>>
>>>>>>>>>>> +enum amdgpu_ucode_required {
>>>>>>>>>>> +    AMDGPU_UCODE_NOT_REQUIRED,
>>>>>>>>>>> +    AMDGPU_UCODE_REQUIRED,
>>>>>>>>>>
>>>>>>>>>> Couldn't this be handled in another API instead of having to
>>>>>>>>>> flag every
>>>>>>>>>> load? By default, every ucode is required and if optional may
>>>>>>>>>> be skipped
>>>>>>>>>> with amdgpu_ucode_request_optional() API?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I guess this would be a smaller patch, but 6 eggs one hand,
>>>>>>>>> half dozen
>>>>>>>>> in the other?
>>>>>>>>>
>>>>>>>>
>>>>>>>> I thought only ISP and gpu_info (no longer there for newer SOCs)
>>>>>>>> fall
>>>>>>>> into the optional ones so far. The usage is rare, similar to the
>>>>>>>> nowarn() API usage.
>>>>>>>>
>>>>>>>> Also, as far as I know, the cap microcode is a must whenever
>>>>>>>> used. That
>>>>>>>> is not optional.
>>>>>>>>
>>>>>>>
>>>>>>> The cap firmware is definitely optional.  Some customers use it,
>>>>>>> some don't.
>>>>>>>
>>>>>>
>>>>>> I thought optional is something that can be ignored even if FW is not
>>>>>> found and then driver load proceeds.
>>>>>>
>>>>>> What is the expected driver action if we classify cap firmware as
>>>>>> optional and then it fails on a customer system that expects it?
>>>>>
>>>>> I guess if the customer expects it, they can make sure it's there.
>>>>
>>>> I don't think customer really can do that without any diagnostic
>>>> message
>>>> from the driver. Driver has to show the right message. If it passes
>>>> that
>>>> silently and fails at some other point, it could be a totally different
>>>> signature.
>>>
>>> yeah, I haven't seen any bug reports about the cap firmware so the
>>> current behavior seems to be fine.
>>>
>>
>> In this case, need to have a info level message when a firmware
>> classified as optional is not found. As it is only during driver load, I
>> don't think that message will be an annoyance. On the other hand, it
>> gives useful info if it runs into trouble at a later point during load.
> 
> This series stemmed from concerns being raised about the WARN level
> message from the core but there is no way to message to the user from
> the core it's optional.
> 
> Do you think something like:
> 
> drm_info(adev->dev, "Optional firmware %s not found\n", name);
> 
> In the failure path for the optional is fine?
> 

Yes, this will help.

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>> Alex
>>>
>>>>
>>>>> I'm not sure how you can have both without it being optional.  For
>>>>> customers that don't use it, requiring it would break them if it
>>>>> wasn't present.
>>>>>
>>>>
>>>> It's working so far. Having all is better as long as loading that is
>>>> harmless.
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Alex
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Lijo
>>>>>>>>
>>>>>>>>> Alex - what's your take?
>>>>>>>>
>>>>>>
>>>>
>>
> 

