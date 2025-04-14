Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB873C369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5402710E14E;
	Mon, 14 Apr 2025 17:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oT16zMgj";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F08110E14E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xz+Fo/5VlYi3UotshZdeUAzR+0qsCuPiWQvtoIRkh7tBPLOIhhMFvHnyIrCJ0Y6FeSMBAA/OWgf9ohVQA0jZGCHS23eV23a1C5/nsuwwlW3tkYF2etuabMNZKHi5PW4oR1WlkQTf61qBmf81Rx96FnbpstwWUTNZyOsg+7LmLOfkweuhtuTKB1dE73O6qeiOMYjc2Yu7gGX5q4fCFCBDcBPEc39yM4GPDiaEKpWe5A+5ZSQH0mzbXgE9PqIJ6olCPCjKOZNFsScRsohinpH0a9RkLir5CrLqCkhjJVuBY0/vNc3bvENhEICzoC12y3ctIM0+kxM0JbBq1ArF6RfrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpPOK+ETh5BsgwivX/W3+t9dE1zjTTUeREuxM97rFGU=;
 b=Qd81kwxOB2sM6qQLYMBsYpBhVBOprAJR/szj4XSGd5EVI0C2cV2LXmtX5Vbw9OTbrr62UfxIh9sG0GRtpMv9Zf/YNzzik9NbxToyKy7QbXHWy3KEV1gSTCZ28TzK1/Px1mifxssQVYxmSzrEHEFwxJ622JvbK3/hhIxgSM6QuBfNZsx+M9CEVwsk8rmvZygWhRbT1kVbDuxlBU9SJ7jjruXYKeKwbu9q1KfvC5U+fvVahFrGz7Ml+iUuP8YQT93HJVI6ghJlfyI+PyxK+YuCuTwQaHNdPn2U5spz/pO09vgHjqqYvDHj8qdKuhwy98TPiA8JttmjkxpQGrOX6byIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpPOK+ETh5BsgwivX/W3+t9dE1zjTTUeREuxM97rFGU=;
 b=oT16zMgjjczHTGLkLFQsf+jr1/28peCdOfTOAL0e6VxClBJVa+RwUH9YdkE3pdQBaqotDkS0KIxWOlFtKSULNbawbSuMRpm6GZHAExSTLBGV25oopiOEmgMt9JlWCxQlf7Ap/Ip7anU5T7a1/VpnvBjIIObnkcB1gXe264bWV28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 17:17:19 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 17:17:19 +0000
Content-Type: multipart/alternative;
 boundary="------------Pi0YRN36L3o0SKfk2e8KVMau"
Message-ID: <7138346b-3063-4b06-8e5a-ec7e42bf21ad@amd.com>
Date: Mon, 14 Apr 2025 22:47:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/gfx11: properly reference EOP interrupts
 for userqs
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
 <4d804b27-c89c-4503-8d36-2e9a35a483e1@amd.com>
 <CADnq5_N3f1PvDMXsEq9M3ZG1Zwahb6PKCUd3-mk455=w97wKzg@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_N3f1PvDMXsEq9M3ZG1Zwahb6PKCUd3-mk455=w97wKzg@mail.gmail.com>
X-ClientProxiedBy: PN4P287CA0045.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c72df2b-1e64-4c60-a467-08dd7b78360f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tmp5RzU4SnR3dXpaeE4yY0RYallrZG5td29DQUYrNXI4Tm1YeUJ1V3pTaFhU?=
 =?utf-8?B?TERyaE1leURMOWVObjJkRXAzZFk3QXVlZy9QVkpYWUUvRTdnek9LMUZ1VGlk?=
 =?utf-8?B?TVJVQ0tKN0xDd1BITHBUSzZ6Q0s1SFVkZUYyQ245anh1L2E1SmtDQkFvODJC?=
 =?utf-8?B?c2hqWVN0STg0eDZRNnR6L3l3WDhvWnNjc1E2NmdaSElYSUM4OFBQR0wyajZa?=
 =?utf-8?B?RnppT3E3V0dPdE9PNHBERU9EeDFsY2l6OHcrNzVVemFHWERCVk5EcFlsa0JR?=
 =?utf-8?B?S3FhdVBlOG9qbWR2Wkt5TmJUeEFnQ2YwUDFRVXpLU2tHZWlpUXcxSVJEUm9D?=
 =?utf-8?B?Tk9ma0wxamNXcktmNTV4M1l3bnJmeTB3UDB6MGptVGNqU1JuMUZOYVFwb2dV?=
 =?utf-8?B?cyt4ZUFJNkhFTjVUSUdOSk5oWHliY2p6U1JmMDV6blJlQ2JrRnNGN1E0L1h5?=
 =?utf-8?B?SDd5MTlidkd5Q2xqR3BaUTVhUnVacGdOUHdrbnlSb1RpTVErSVNoLzBkOG1Q?=
 =?utf-8?B?VVh2alJBZm04Q0xVSlljMHVTcE9kcVE3U0F1ZmllcDArNjdpbFlMaHhWdnoy?=
 =?utf-8?B?QUNza1JEK2VyWTFmbGF4VUpOZmsranAzYzl5M1o4a0ZjY0RwYUt0UzBDc3pr?=
 =?utf-8?B?NFFYeGloc0FSbm4wbS9oVEZlWklOdWx4ZU50bVo5TDZmODdqbFVQRkkzQmhK?=
 =?utf-8?B?SzVIU2ozZFI4dm5TVHJXWEdKNVRKanB5WDc2Ylc0U2IxMzZpYncvY3JabVI0?=
 =?utf-8?B?cUlTaTU5a1p3NHg2bVZqUkRvUWhmTDFBdU0xdzF1dDl5QTMzaTUyWEFlem94?=
 =?utf-8?B?YlczWG5nRjZBQWZvaC9CS3pDWS80MGlWd0xjTTQ5MU5abzJJOEowT0xmRWNQ?=
 =?utf-8?B?YzhHNG5iZVBTWGJVbDBJSWttZDhyOUNENFAzWWZ3bE9DbXQ1TmhHVXVpdi9k?=
 =?utf-8?B?UWdxODVYZlZzT1JJbm12UDQyYzV4UHZ6V2pFV054M0VjK0Y3UGQ3dEFiK1FG?=
 =?utf-8?B?V2xkcW1MblpIeXgzZEs4RGNSOXROVG5KandTcVUwRGxuVi9OeEQ3ZXpLeENI?=
 =?utf-8?B?ZUdPK1E2c2Y5ODNMUlB5MzJDU3NlMGpzMEJRTlNWV29zZnJLbnZtSUxWbDRt?=
 =?utf-8?B?UlB2NytXWVY5L1VxbHR5N2E4QU1KcVk1a1R3aTc2TUZXQ2hiL0c3SlZmd3Bt?=
 =?utf-8?B?R1MvZkIyMWppRlZReDVEeWJXUmFkb09OamVuclBabDJSajIxMzdSRThYUjhZ?=
 =?utf-8?B?djNTVEdVSFdITGp1M1VXV0pkd0NqMDlEdXIyaTBhQmxXQm1kRHAwRytFYytW?=
 =?utf-8?B?eUxDNUZuK3hyanNPZEI3QjhiWStRNFVEamFmclkyUG1NcDhGbVIrbzBsV2Uy?=
 =?utf-8?B?Ky90cU5hdjBiKytZOCswMnE2N3dSa2cxTHFMVXdhdW4vODFuaDEyc2RoUkQ4?=
 =?utf-8?B?cFBKNmMyVkF5Ym9xV3hteGxJbU1aREtVNFFLSTVHNzJHOE5sZ01udkhUeEc5?=
 =?utf-8?B?K0lQM2FRc0UwRWV4ejNteXhCQUdzdnNmWG9zYVEwVmdKUFhuZTVKMWZTd29I?=
 =?utf-8?B?aWRmSFZMU3NTS0VtVHJnTVJZajI5cGRzY0N4cmlXMVJDUU1xRXRKVldoa2w3?=
 =?utf-8?B?M1hEYkRkMFZ1V1o3ZUxLbWlLMS9RdElWMWlYN2FTSVBDMU1xS1dxZlVsbzFR?=
 =?utf-8?B?d3IxTzl4Njl6MXJhT1NCQXBqTlpCWDBUMWhiOFpuOUdpdnhxalVHNndNd3Jl?=
 =?utf-8?B?Mm83ZDFReFBwY1RPMUNZbG5rKzVLVjZlSWdJdjhNQ0lTTWtudmhkcnJnM0d6?=
 =?utf-8?B?LzhRS3NueU5wOXNadlZoZXR5VGpYRWVoZVJRQXRmRUJaWWdmczNLekF4R1BU?=
 =?utf-8?B?ZzJRZThoU3d6d1pQeVVOSEVzS0xzclcrVmxGR3ZhT0k1WVNhMHovaThiZGRh?=
 =?utf-8?Q?L2UlDw/pOK4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzlWVC93VHpTSVJsUDFHWkNlTXlQSWx5YWRHMzZDOGUxNWNYZlQrb0I4bGor?=
 =?utf-8?B?VXRNVjhUY2lySC8rRlAvV3c5eitkL2xZdGtOK0hRMUhpVlBVbytxVzRYNll0?=
 =?utf-8?B?WE8zVkM1NzJXRlVEUkdtc2tWZmhyeG5lcSt1RGFKbnBZbkVramtiTkxqU0lr?=
 =?utf-8?B?aVQ2eDUyQUhUeFQ1NkdIZG5KVG9lc0VSN1UvRURxZm5jK3J4NlRzdzJaK25x?=
 =?utf-8?B?UUVoZHNjVC9ZTDVVRy81THhaL1NDSDkyVkJtWUdwZEdjOTdkTTFFQlRXTU9k?=
 =?utf-8?B?SDUzUDlXcmNSZmdUaXBBUUg0S3lRRkxlS1NBSndrQStQYzlHSkpMaENXc2NG?=
 =?utf-8?B?UVJJYmo5SXZkaVVUcXp6SndCYVovM2JLZngyZjdaQ3RDQkhCWjZOejVxeHRq?=
 =?utf-8?B?M08vRDlmWjBnRVdLUzBSYUVKU2FGeGJmRW9yMzROMXJKeFVHaVl5UDRieWJo?=
 =?utf-8?B?eGFVbEs3dFZ3Qmw3aFRpTzMrdjFoaEQzdnp2dlNDZXUwN2huQ0puQmRaUEVU?=
 =?utf-8?B?ckRLREFWNlI3TW5HMms1QzV3MlRiY3FNeXdRTnAwcms3TEIyWEM3QkdyQ0Z1?=
 =?utf-8?B?N0FSa25NbllJOUVlWjltU3lmQXVxdjVTa0wzM0dvOHZ3bVZpdkc0QWNSN0ph?=
 =?utf-8?B?dHVOeDc5UHA5c1JocGhTcVlJTFRCdlUzSTBlWGlieUhTMXM2TVlOdWE0Ymo2?=
 =?utf-8?B?M1pYQjZtdFNYOW9kM25vVmY3V2ErMEhVaStTZStlTzVHSXh4eVFLNzAzUzRs?=
 =?utf-8?B?eEg1N0dmT3J6UjJUVDUzSlM1bk9tWGYrNktINnBKQTVlbEpEVDczK2RWUkp1?=
 =?utf-8?B?NE53VzRlclJNaW5DY1FldXpyVE16d1lyVng4cUtrMnRLWkQrWlJTL280bERO?=
 =?utf-8?B?NkxTTnEyemdRRmNFcEtqSjMxakgvdTN4MjZ4NWVSVXNDdzZsQ0RSVG4yakFM?=
 =?utf-8?B?WkF4aHpOWnVUM3lIbkxjdk04dCtTMCtiNGtiMnB0SzFkNzQ0Ni9DKzVBRlJI?=
 =?utf-8?B?OElyRnU5MkRZWjNIVFp2OGF0UGVBZmovK29LQ2RRRDNrODhRL3dGdUhxSVZ6?=
 =?utf-8?B?bmcvY0FMRlRFbmZlaWlxNHlJd21ka0t5ZExLbGJmMVN1YS84d0VzVmRkQTRI?=
 =?utf-8?B?eWR0NUZFZ2RyNkk4KzlodWVTMW5tYWVOU2ZKdFh6cFlMY29TN2djUHpMTVZL?=
 =?utf-8?B?aUJIcWZIb29NMm4zbjVGZDBsNzVhYnZlajV3V1I3VGZtUzJEOXVabmswc1Jr?=
 =?utf-8?B?Zm10Y3lQdFZCTVgwVVNFdFhMejl6VW5POGdzNEJ6RUNnU212ekFJNUl2TnVj?=
 =?utf-8?B?RHVwaW80d1FFdWlFeVJhYS9uLzJaSDREdmdzaXNoMHZ4WmVsOFFIenUzZ3Jn?=
 =?utf-8?B?RmJYa1V4U2V2L1FhM3EvdHpGeWhYclpiMzgyR2VTVXN3QWl0NUJZdkduZldl?=
 =?utf-8?B?eHBVUjc2Uk5DbE93Q1RiWVpnSjhxRG5iRDgzZ0p4NmVka2FqTlJBNmQ3YlB0?=
 =?utf-8?B?MWYzS0JOcFRuZnJ2Q2d0OTVFbDFvZ1Z3bTFJdDBsYjZUWSsvckg3Ky8zOUlL?=
 =?utf-8?B?OUtCMTZzai9JUlpDKzFickRNQlRhVHg0VGxiMTdxRG4zTE0yR3lOZTF0c3R5?=
 =?utf-8?B?b0NibFJuUDFTMEp3WEpUNzc4aW50M3JEd05udDRmaHl3cUhlNHdzdHRhZVNU?=
 =?utf-8?B?VWNJZVB6VVJJSWtCZ3o1YmpaZkRldjNFWFRMK0x1ZG1obm0vSzZBcTZ6Q1FM?=
 =?utf-8?B?ajVJOWdwR05ubHMwWUNtWXNiSW5wSmFYQnBqNEVzc1hmUCtlc1laNlRsUno0?=
 =?utf-8?B?UjlGSnMyc2xvQllMOG1LbnhLTWlDWjQzeWhucjdjZG5mT0ozMm5ZK3hGSjdu?=
 =?utf-8?B?Z2tMQWhuQVFNb2FMUkNlazhGRmJZaENSbWR2cVZBc0pFeDZvWnlWWHhDenZW?=
 =?utf-8?B?d2x2VDZzdG5VMVFpU0gzNU5tcVBDNkdzMlV3bjNOR2NoNXZUY1hHTUhrVVor?=
 =?utf-8?B?aU9LOHBXeWwwSnBXdStKNkRGL1d4S0pqbU9ZTnRmejE4L3djZWN6djVOWjM5?=
 =?utf-8?B?blQ4VDgydzdiOCsyMzZsS3E2Q0FLRnBNaWpNL1E5WXNqOXZCRVorcFVaM1F2?=
 =?utf-8?Q?3wVxWJU4qD6XMj4cbz9k/xMEe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c72df2b-1e64-4c60-a467-08dd7b78360f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:17:19.2712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pnx+YpTHRLo2H/u7ynaBNfQTdpn62Gzt4XRFw/t05vYx4i+31tKBMsnf3BO7OhhLsRVE6ygvYEYgX99QVZBuiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
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

--------------Pi0YRN36L3o0SKfk2e8KVMau
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/14/2025 8:59 PM, Alex Deucher wrote:
> On Mon, Apr 14, 2025 at 5:44 AM Khatri, Sunil<sukhatri@amd.com> wrote:
>> This is how i see the future of this code and we can do based on it now itself.
>> disable_kq = 0, Use kernel queues.
>> disable_kq = 1, Use User queues.
> disable_kq = 0 means allow kernel queues and user queues.  disable_kq
> =1 means disable kernel queues.  I think we'd want to allow both at
> least on current chips.  I think if we want a general knob for kernel
> and user queues, we should do something like:
> userq:
> -1 auto (whatever we want the default to be per IP)
> 0 disable user queues (kernel queues only where supported)
> 1 enable user queues (user queues and kernel queues)
> 2 enable user queues only (disable kernel queues)
>
>> In case of kernel queues we should not be even calling gfx_v11_0_set_userq_eop_interrupts at all. Instead its better if we add a this check "if (adev->userq_funcs[AMDGPU_HW_IP_GFX])" before calling the gfx_v11_0_set_userq_eop_interrupts. I am assuming there wont be any mixed use of kernel|user queues together. Let me know if you think otherwise. Regards Sunil Khatri
> We should only be calling it if user queues are enabled.  I think
> there will definitely be mixed user and kernel queues on current
> hardware as we ramp up on user queues.
Alex, are you saying we could expect some device where Kernel queues and 
user queues will be working in parallel ? If that is the case i can see 
we need eop reference for both the cases and this change then makes 
perfect sense but,  if its either kernel or user then disable_kq feature 
check looked better in control.


Regards
Sunil Khatri
> Alex
>
>> On 4/13/2025 9:36 PM, Alex Deucher wrote:
>>
>> Regardless of whether we disable kernel queues, we need
>> to take an extra reference to the pipe interrupts for
>> user queues to make sure they stay enabled in case we
>> disable them for kernel queues.
>>
>> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 7274334ecd6fa..40d3c05326c02 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -4836,10 +4836,10 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>>   static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>>         bool enable)
>>   {
>> - if (adev->gfx.disable_kq) {
>> - unsigned int irq_type;
>> - int m, p, r;
>> + unsigned int irq_type;
>> + int m, p, r;
>>
>> + if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
>>    for (m = 0; m < adev->gfx.me.num_me; m++) {
>>    for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
>>    irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
>> @@ -4853,7 +4853,9 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>>    return r;
>>    }
>>    }
>> + }
>>
>> + if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
>>    for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
>>    for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
>>    irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
>> @@ -4870,6 +4872,7 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>>    }
>>    }
>>    }
>> +
>>    return 0;
>>   }
>>
--------------Pi0YRN36L3o0SKfk2e8KVMau
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/14/2025 8:59 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_N3f1PvDMXsEq9M3ZG1Zwahb6PKCUd3-mk455=w97wKzg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Mon, Apr 14, 2025 at 5:44 AM Khatri, Sunil <a class="moz-txt-link-rfc2396E" href="mailto:sukhatri@amd.com">&lt;sukhatri@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
This is how i see the future of this code and we can do based on it now itself.
disable_kq = 0, Use kernel queues.
disable_kq = 1, Use User queues.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
disable_kq = 0 means allow kernel queues and user queues.  disable_kq
=1 means disable kernel queues.  I think we'd want to allow both at
least on current chips.  I think if we want a general knob for kernel
and user queues, we should do something like:
userq:
-1 auto (whatever we want the default to be per IP)
0 disable user queues (kernel queues only where supported)
1 enable user queues (user queues and kernel queues)
2 enable user queues only (disable kernel queues)

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
In case of kernel queues we should not be even calling gfx_v11_0_set_userq_eop_interrupts at all. Instead its better if we add a this check &quot;if (adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX])&quot; before calling the gfx_v11_0_set_userq_eop_interrupts. I am assuming there wont be any mixed use of kernel|user queues together. Let me know if you think otherwise. Regards Sunil Khatri
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
We should only be calling it if user queues are enabled.  I think
there will definitely be mixed user and kernel queues on current
hardware as we ramp up on user queues.</pre>
    </blockquote>
    Alex, are you saying we could expect some device where Kernel queues
    and user queues will be working in parallel ? If that is the case i
    can see we need eop reference for both the cases and this change
    then makes perfect sense but,&nbsp; if its either kernel or user then
    disable_kq feature check looked better in control.<br>
    <br>
    <br>
    Regards<br>
    Sunil Khatri&nbsp;<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:CADnq5_N3f1PvDMXsEq9M3ZG1Zwahb6PKCUd3-mk455=w97wKzg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">
Alex

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 4/13/2025 9:36 PM, Alex Deucher wrote:

Regardless of whether we disable kernel queues, we need
to take an extra reference to the pipe interrupts for
user queues to make sure they stay enabled in case we
disable them for kernel queues.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7274334ecd6fa..40d3c05326c02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4836,10 +4836,10 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
       bool enable)
 {
- if (adev-&gt;gfx.disable_kq) {
- unsigned int irq_type;
- int m, p, r;
+ unsigned int irq_type;
+ int m, p, r;

+ if (adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX]) {
  for (m = 0; m &lt; adev-&gt;gfx.me.num_me; m++) {
  for (p = 0; p &lt; adev-&gt;gfx.me.num_pipe_per_me; p++) {
  irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
@@ -4853,7 +4853,9 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
  return r;
  }
  }
+ }

+ if (adev-&gt;userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
  for (m = 0; m &lt; adev-&gt;gfx.mec.num_mec; ++m) {
  for (p = 0; p &lt; adev-&gt;gfx.mec.num_pipe_per_mec; p++) {
  irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
@@ -4870,6 +4872,7 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
  }
  }
  }
+
  return 0;
 }

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------Pi0YRN36L3o0SKfk2e8KVMau--
