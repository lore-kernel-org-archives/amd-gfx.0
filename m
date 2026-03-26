Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B864310A3D81
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565F110E963;
	Thu, 26 Mar 2026 12:08:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u5V4zIZr";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB3310E963
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeMUiFDQU4lKZMcE7wWraXp6bxDt2JBgOxq7bqJ5Z7cE1b9Y0uDtYPQwzzghMmRXFhzbDjj1V8A9HzhUlIoxwh90fAYi5+4AMKXWPjm6pmiAlHbhd/JMZdiwGLTmhClU3Ho/lZBC7bxj2qiIkggObnhLi9SE4ATKyyyHlZeQ3PVV9gaWAHzoCj8jDcnfI4kUDrUu1Dtxq9cE76oKhqcxWBPdROo7l+jpjn5k1PEBwWbJubRqVdMFZF/et78qDLGhoLWxYTzyoQ1XV+/Yyn69g+d+S2Fu8lXlN9sIEU/sRUHmZKMAjztPvMY467o++9mqDARgKGCQTta1mot66/5r3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQkeGgMkfrVH16fhT5cT89ILwMkGBs5uWVfViySkVUE=;
 b=eXOzFklYX85x26VejvpBjo4+gpast4OCHs1ZBleR5ToH+vT2aYimLhvS2DGyJSjFcX3nHTuGBAvwPiITKf2GeYsiEsWsqotOKYeK/4VzeHctuuQRR/sXq5dcwT6bjdTGY5ivLxXq4qvFZGk4zjS9Spilhq8z6pO735TLa6h6pn/Dh8MEFbhLV9pBbega4d0QXrbZ8QeYpz6zakIAamKcYp6qPRoy3J+vfQi9wTks1st+/cwWQIEqu06/ydKTim2PheViOoFVWr35JsdOrRevQ+M/FUhEymcPV4gBEJcIoToOXiW8G2n3ZIMuiR3gyZMc39LQ0D0sIJksk6dtTk2Zcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQkeGgMkfrVH16fhT5cT89ILwMkGBs5uWVfViySkVUE=;
 b=u5V4zIZrXXf6QfP1PjwY37+wL5B8gypJLUrzk0AkWGgNSGAdqXW+Vf/OaynBw/mSXFbLOg+CSbcDFzS3Fn0TDWQFOhYiJsOQNAz4A5qeeXiogf/4FUhVqh48lQ32HrUaAiwABR2+7WQ5dt12QnlARwLVOtPyGHwBqvaW5g//f5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Thu, 26 Mar
 2026 12:08:25 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 12:08:25 +0000
Message-ID: <6bc42907-3370-4c92-94f9-9a873f50ede6@amd.com>
Date: Thu, 26 Mar 2026 13:08:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1 1/4] drm/amdgpu/userq: no need to use local variable ret
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260326085601.2665215-1-sunil.khatri@amd.com>
 <20260326085601.2665215-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260326085601.2665215-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::12) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c97015-db13-4293-f694-08de8b3061d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Eo2kGZy4fYYmpTWYEL0nGfrNxG00eX4zoRJ4dO4CAcVlWJOnmlDxVi0xZqKonCAI7AzXbOwJypAYWtbVJlVZGGEmZqhcI5vD3YZl56+KJcVdnBffIErrKtPXuq667K2SCibWqyRPO57/KxhxPK2q1gcB+iCPn9i3rM6UZ5jrkJe8Ax9HgnGG0KXYQ1Lwvlz8CSgJk4SNMuelk9o8hoNIU2QshL114iX7az3QvAMs0yLW0sLlwcZuh9LRTqysMMOesJEet8INT6jSaAppENeQ+affn145n2dJ+dPWicMbZM5g19r5e/jrlLtgJNN8y9W4+sZwazZuPJnEmkUOil4lJoqOjNsZwIzF+gh/soxsANMlGEY1WA57Kq1VTj0U64tZJxDrhKxsr6gpK0u1GnV1IVx6xWdPE3diahc3kIBzRKdXjALZV26f4hrjNOU0+wsRvj7er6DCzJc6xM3Wyckv083FluYhKQs9pmB5/RLqL7zn3SCsbYIW9Kyr1fl2jj90Nv8h6MdtLEQ35Nj6pjs5POwGnCpRCItyitm4EJmVNl/ahemDnTGmvZ+v+ZbnqIFnZLSYb0w3O3V2TAOJowrfjLxE0xPtG5Qmw+45YarlyvJtod/qhBt/Mkh3zHHhoaWxCvMOE1ekS8pn8FuZlE25UuIAXtiyTSYhCbx+bKK35roTg7SiAsVBFonGHkoBIVYhhGpilAGyp51JZ9IFfi45HmKEWWrZzzqEIeQM4JX2oeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFh3VDZrU2tOdjFkN1p5SU50TXJ1MUo5clNzSWtvTzJjVmswVTJuM0dvdkZR?=
 =?utf-8?B?eUNJU2FxeUtuR2Zrd3ErQXlzMTl3V3BkcWdsU0I0TXJXcGU2SUFEREZNcFht?=
 =?utf-8?B?YjZJTFVwQU01NXFMbk5kYTZCSnQwaFhNL3JGbWd0cVZ6NUtseFllQWFRUWo0?=
 =?utf-8?B?Q3pYU0hBa2Q1THVjUzE4V3lSeW5oR2RONG5PV29Ja1E4Q2xTb2RaeXdOK3F4?=
 =?utf-8?B?TWN1SXFyVndyTlEvQVZlYzRrK3BDcUdhbmY0c3J3VGNOQkdjdGpJd0NaaEJK?=
 =?utf-8?B?ZHE2WFlJenRycXF1N1lxVlNGb2FOcVFDaHNoZmxlVUFGUTV1NjVyRzY5OXBX?=
 =?utf-8?B?VXhIUnM2TWhVR01LbXpTZVlON295eEVuNm01RnVPRnh3U0xMU3orVmxCT3ov?=
 =?utf-8?B?d2JvWmVtcEtzeHlKQUJOUjk0Z2ViWmFqcWNCWHdrTFU1THhvcHdyblFZTENw?=
 =?utf-8?B?eHlCZ0laREdZcnEzOVdlOE5xWTFIcndNK3QvTlg5blFPV3B1TUxUelNPdFNS?=
 =?utf-8?B?VDJzYXo2RUV3VWw5anhrSTNZQUc0Y2VIU2xWSjAzOEpZNlUvNnVEbjVUclRY?=
 =?utf-8?B?L29VS3Y3R1FlUTF0b1FJRENCQlcwbnRrWWRUQ3VEUjNJSmtDUTVtT0hKUTRn?=
 =?utf-8?B?bmpybGp5Vjl3YjI0UHNoV2w3cWJRQWdVZ3BFZjhaM3hrWTNMVDh2bFBYc0V1?=
 =?utf-8?B?d3M3UUtVRXg1Sk5oOHh6YThmTzZyN3M3ZHRualdRWDdIci90SmYwNTZZSVZ4?=
 =?utf-8?B?YnBxTlpkRTVaNmxSZ3dhUjJQV1UwaEdiQkgyZ2Vud0Ixa1BiZU0yd2hwZWo0?=
 =?utf-8?B?MFhIUDBBeHZUaXFxTjh3ZnZSZ0RhUFVKU1Z6aEs5eCt2dTdVWmYxVytiMG1p?=
 =?utf-8?B?cHJkQ0lwd1E0SzZkNDVMdWdXWG9KcHByaVlhUnQzQ0x4b3YrMllWZHU3YU9m?=
 =?utf-8?B?UGJlOW9SMW44QW1kR1N6b2pqam1QZ1Nxam9QOEZ5UzBJaWhyVHpuUll4R0J1?=
 =?utf-8?B?bWpQdmZpTWpMaFJ5THNXY2pKWjV4NFlBSzlPZk1UWmZVcHZqcUdOemNGQ2NW?=
 =?utf-8?B?VGtFQ0plMCtzU1p4a1pqcmhQTFBtQ2tDN2pZOUw0RHBqV3padGJWZlhId2RL?=
 =?utf-8?B?a1hpSEpGS0h0Vks2alpxYjkrNlJBVGQ2d20wNTI3Q3U0Qm9TaWVEamgxM0p6?=
 =?utf-8?B?TTMrVlN0SWxuZDNqZi9mYmhBbjlxdXBkZ1Q0aklqVktOYjhrUkhyLzdJbXc4?=
 =?utf-8?B?TGlicEJ5aE5adjRMbGpYc1BmSUZETXVlcjNoKzFYdWNIZFhrU2NpWHV4MFVU?=
 =?utf-8?B?ZXdTbjhUblgwMHBXVUNpUUpBaWd6blRxdjRLWHRudFZETnUvNDN4ZmRJTHo0?=
 =?utf-8?B?UDlIUk1kblMzWXRtSzc0c0dLUWRHekYzM2k4VmMzT0JCa3EvVjFEZ3k5Sks1?=
 =?utf-8?B?QTJDZ3lmRmcwbDhQakxPL1pNcHZwVWNxb1pMWUxmK21VUWtBbjZyc3J6MVFK?=
 =?utf-8?B?YVdHeklmb1FVTW5CLzcrQkYxNEZ6bzU3Z0NGdGRqZVA4THl0L3liK3AvUHFa?=
 =?utf-8?B?d2FubmZZOXNIeVdhQ1ZvRWRyS2pEQzNudXZZTkhOQnVSZ1lxbno0U09CRXd2?=
 =?utf-8?B?M21WNVZqSTAxY0QySHRCNWNQek9XMjBvdHBweDZwdjJQNW5pdG9RVnpoeUtk?=
 =?utf-8?B?VW5aOUtMZWVEYXNtMlhQWkcvMUIzaHFQeUJXSFdjVmZIZjFjdjU1Z1ZUbVBl?=
 =?utf-8?B?Mmx0RDlSWTV0eXRPT1pNWTQ1d3p0UFJwcW1VeTBDcHVWK25ZeXY0L2ZKSWI5?=
 =?utf-8?B?bldUMDc1Nm9tdzdQb29WazZpS2JacTdUKzcrdXJ2KzBvaGtVN2kyeWgrKzBW?=
 =?utf-8?B?SC9aYnJIaEQvc0x4RHh3VEF0endjQkxMZGFocDhZOTJCeHlzeU5pL3dtUFM1?=
 =?utf-8?B?K096bDZ0bkZYZU8vdE5xeGZtcFpFTEI5aUJGOUVkNFJkODNrRGhYMVNRbU52?=
 =?utf-8?B?SDZOdGtGM3JBb3MzUytLQWNCRnpCZjZwOHpoQTJOaHVzMGwxS1hzYkF1SDJs?=
 =?utf-8?B?cXZVZUhya1E4aDBoMTNYTkJQSGlQUDI2dEJNZlJ5ZnRyczRmRGRlUW04eG1M?=
 =?utf-8?B?cG9Ra1lCUWRhTXFJcEhuMkRndEJINWs2cFIxUk9WbVpNRXNqZE1qaFJMclpj?=
 =?utf-8?B?ME4xWnZqOE5SREh3ekhNQ3dMaXFwenprK3VKL0ZiYm1HZ3c1V2N4anAxcm5V?=
 =?utf-8?B?enhZWTQrUDJYUmZUZXgzTy9GR1liNXd5TnE2bHZTL3JBb01CREVsME9TRDhE?=
 =?utf-8?Q?l20GGYg0Isfej/HYOQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c97015-db13-4293-f694-08de8b3061d5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:08:25.2088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QgAJlGNqxltg5vojbcU9EQCB5ODny5Fpu8SCJJ5snHqepzDQsxoj1eHb5L08+O6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749
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

On 3/26/26 09:55, Sunil Khatri wrote:
> In function amdgpu_userq_evict use the function return
> value in the if condition instead.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index aa0e6eea9436..2a1832fce6d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1308,17 +1308,13 @@ void
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_device *adev = uq_mgr->adev;
> -	int ret;
>  
>  	/* Wait for any pending userqueue fence work to finish */
> -	ret = amdgpu_userq_wait_for_signal(uq_mgr);
> -	if (ret)
> +	if (amdgpu_userq_wait_for_signal(uq_mgr))
>  		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");

That actually looks like a pretty bad idea. Instead we should start printing the error code.

But before we do that I would rather like to know why amdgpu_userq_wait_for_signal() can fail?

That should never happen in the first place.

Regards,
Christian.

>  
> -	ret = amdgpu_userq_evict_all(uq_mgr);
> -	if (ret)
> +	if (amdgpu_userq_evict_all(uq_mgr))
>  		dev_err(adev->dev, "Failed to evict userqueue\n");
> -
>  }
>  
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,

