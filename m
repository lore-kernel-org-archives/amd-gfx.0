Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A6BCCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 18:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3EF110E2B0;
	Tue,  4 Nov 2025 18:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k7BS3n+K";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E48B910E2B0
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 18:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMbHS/gA8hKnNugOSAP3TAioc7MMEDQpNq0aKGlRQdv6D0sMvhSjFNaoNI9P578lJ79OTdNtyNwvZ+Ig7ZNZAGDg5F7b5IXTeYfdOpqhxnqBGUi9MwJGbM9ylEowwS0KhlyvC3i1NzUvy/J9h8lAjrLHmKASRkErpmposYYdrYnr0gda90mOwu62j2l2U4zmp4GiMGT2IFrwulo2EYvzaQKxnqq8yP0HcKjXa7GZJzaqOdpo1Yf0VCP/W4ees8dNsigwICW9p5EA6dBemaQRTvh9z5acf5ft9r8iLAkp4j0gd8ApqlPPPFeCis6xfHTsxYQagP3QKrJUsA0EGLAUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLELQYHIeMW7ku50iewy4uXQ7MXTgpYEaeTcKK4apxM=;
 b=TGAHfNnwIqRKuQYq2Dh8Sh1B4m4AIE4qcILIOl8Pg19rh1G7rR8brQCcTf1vdR9cz06xH7MRuGj7D9ApRkDNwZVqAQZvKpakoMyfusCmW6gTMXT0/UVYGjOr4oN5nj8eSYPfiGRUVgLw99egA/HvkUangWbdmrQ/RLijTb5pDFfQu1Waweo87aV37FXMoSB7Tf04DKjCciWIPEnsOKERpRSg+J8I1K+bFim/dIjw9I4KpSm/tdqy4auRZZGyb3mMYOq5yWJt+jUwiabNf8gDNrf6dSt2mzqOyHApSedbMZN0pz1GYpXzlNSrPHN16zH89u11nhptWTxenIZ/S49OXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLELQYHIeMW7ku50iewy4uXQ7MXTgpYEaeTcKK4apxM=;
 b=k7BS3n+KYYyQvFFi7YDQmlCrK6qw4bdaL9gGHWAF/59GivGhEh702+Mdj9/7Lb5Ua+PsQLk3cinW5ufr0bNSE+vfvyXMFvbnRyrljCryasOGf7BCSTc8ad7zY5Gn12J3be9HERG3SwaWkw21n+wFVjy4eNkrdGkjS6f6w/j50w8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Tue, 4 Nov
 2025 18:52:07 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%6]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 18:52:07 +0000
Message-ID: <d7569ba6-a915-45fb-b025-e9ab1047c616@amd.com>
Date: Tue, 4 Nov 2025 13:51:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: need to unref bo
To: Alex Deucher <alexdeucher@gmail.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com,
 alexander.deucher@amd.com
References: <20251104163932.263193-1-David.Wu3@amd.com>
 <20251104163932.263193-2-David.Wu3@amd.com>
 <CADnq5_O2pf8w8NbK8QEhPDtFgqrhXsGPv4U_i-+Ov4UzLLUb9Q@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_O2pf8w8NbK8QEhPDtFgqrhXsGPv4U_i-+Ov4UzLLUb9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::29) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: d2175317-affa-45ef-866f-08de1bd340c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0N5b2taWXM1NGVDYVNtbTk1ZHMwSzlSOUNJd2FtY0l3a0J1VkczYURWb0lZ?=
 =?utf-8?B?OFV0K2Q5cTZHMTUrNTN4QzVFMC9LT09wUURQVW9ITFFGUC9qQXNMZHVtZmI0?=
 =?utf-8?B?eUF0eWcyaU44ckRpTkVRQ0JseDZ1dzVYZnVmMjVRNlJtRHVFa3ozbmp3eFY2?=
 =?utf-8?B?ZnBsUktZa2Z1WXIrSkNQVEJaZUlIRXFta1ZIWEZWWUsrbHRRWVJTM1lNNDFp?=
 =?utf-8?B?WnlPZnJTY2pBc0JoMHB3aUpsbFB5bkw3WXpVeU5INWhWT1hEUG1TZk93OTRn?=
 =?utf-8?B?b05IRVZybzdBZ3Rlb1VlQXZQZkNWQVZacXFRdFlRME1FaDhaQm54SWg5TWhj?=
 =?utf-8?B?S3VqRC9rRHVEcStlaW0wT3lJOUtnZG5wNWZBQUd5NDU4QXpoM1cyS0pGUnlS?=
 =?utf-8?B?VzhQb1ArTHV6ckF6ekNoUHRzMDRVTXFZYnBFSS9VQzdQbTZGNUJZM3g3ZjAw?=
 =?utf-8?B?b3kxQzZoaEhzaGNBbzMzczRhUnFweWF6RUNORDJJWjNXOEp0OEhjbTdwc0Zz?=
 =?utf-8?B?dHA0aEdCMlRIa2FyeGZGQ3R3S0tBQk1oQU9lc09zclprUFlhTXBrenNnSk1x?=
 =?utf-8?B?S21wcnRsN0dEQ0Vic3d5UFFpN0hyajhTVWRFamZBK3h0OXhBaTBFSXdLQkNj?=
 =?utf-8?B?cHcyaG1vUG5TSGNPOS80aFRQZEZCTEljSTNEUStlUzRhNTZQNFkwZVVuMDJY?=
 =?utf-8?B?ZDJCVmVzT0Z4ZlFzSDFZWk4wK04vYmRKUnNGdmhRZU83cnVwTmZpcHFZdWZz?=
 =?utf-8?B?S0xqbFEyNjAybzM4MXRqWjNNU1ZwTGVIQmRXYWN5TzZIemc4RHJFS0RHbzlm?=
 =?utf-8?B?aTJCaEtjWTVaYTc2MmllS2MzVi9nVmhIUWE2L1ZiOWVtSmVLditlYVIvZkxD?=
 =?utf-8?B?L2ZEUHc2enJzSXROK0FhcktWTlZxUE05bisrRzVOYlVZRE9BK0hHL3JXS0Yr?=
 =?utf-8?B?ZklHbGVIUjNJRHhmQVZETWNsbGxSS1RZV1ZiK3IvWDhqTFN3ODg3WXRLb2g4?=
 =?utf-8?B?QmN3NElZaDNhNVBkcXlNNmljWHlvbFc4OWJBMmVoVkdsbnBQOG1oUHZ3bXNp?=
 =?utf-8?B?TE1ENFZxclBjRGtzNU5EaWlXSG52a1IwQ0o1d3FxQ0JSeitlWnNUNEdRa0FG?=
 =?utf-8?B?M3pyUjZMTHRYMG9BY1BadCtNQ2d1bmo4Wm1reFBvOVVkK3FWZUtJTUJ2NUVG?=
 =?utf-8?B?QjAyN2NCdlFKWHdsWTByaWE3UEVic3h0cEFQNndkNU1CYlZKZGxSS2ZIQThk?=
 =?utf-8?B?YTdFZFBUOXRuaC9RWU5GUnp1ZXE4eFN0RDFGYWk3SStvMFVPL0Fnd3lLamdw?=
 =?utf-8?B?bzNoS2xJOUdJbVh5ZXNrV2QwNk5DM2RDYlYzem9ScW84RWlpdzJvUG44TTV2?=
 =?utf-8?B?azRadVFHOXFJY0dVVE5LbGltbStyQzNOcVpIcTg2WVlZZFBiOWFUekQ5Wm0y?=
 =?utf-8?B?ZWhZNXlNaVozQm9sNklwZHNqZ3M1TS9wNTJWSmE4NGM3TVIvdUVuOTZHSUYx?=
 =?utf-8?B?cmx2cU1raUVDNGJXa3VSU0kyT2hrY1dpOU9kalJLWEdoMEUrdHNLckw5c1Qz?=
 =?utf-8?B?MHJFQ3pSR2wvVHltNmUyL3lPeklVOVZ3YmxHb09FcVVGUzZ4TGxMOWovN055?=
 =?utf-8?B?YjNSUlFIMDQvcFJNZEJpUU1wZC9XMFNTWjZYc0hzTDJWRkFVeUhnbXBYODds?=
 =?utf-8?B?UEs1aXlQYlQraEpSQnkvZ0JyeUc1SXVPMmNlanFuUGlTOTVPTU84aVA4QzB0?=
 =?utf-8?B?aUxSQ3ozSXhtQzJLbWJtRktnMncxbXljSjlOcEl0aVd2VUk4UWFRR3dGT01M?=
 =?utf-8?B?YS9rdGJySDE5cmxBbFNrYzVTMTc0UHVwSnh2Z2JqTFRZM2dwQkZZM2RLWXJD?=
 =?utf-8?B?dmxKTlJxaDBtSGxjVDZ4b2dUMEhHQ0tQWk5Dd1RnT2VUd2FYSVhQa0hWVkNC?=
 =?utf-8?Q?ZImIMJWzRsGjvzZn4TmjT7HbrHIaWmsl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1lxK0VDMHF2QXQ4MkxHVnlGSG5HODVRMG52aEtmbWJrTmRlK05ZTHc3dGpi?=
 =?utf-8?B?aEhFTEpUY2FXdjl4N0QyZTdoR2paaDJtV25hNW96dUN1MjFIUzZEaGZqQ2Iz?=
 =?utf-8?B?cHFEc2p5RmJ5TElHOFVBYWhoRk83eGtmNVJVMSszVnhnMHM3Yy93NHgzQ3FW?=
 =?utf-8?B?UytSUE9OUTRseEJiT0lPMXk1Nkp0SGVXcWRDVS80SG5yRE1kWGZkazZNOFdL?=
 =?utf-8?B?WTJlK2gvcGpCV1JHMUw1TTVLRHA4SitKU1oyTEdLWUZ2cWpkZndHcHYzaG9a?=
 =?utf-8?B?SmNuQ1EwK1lEMytLS1FibFA3L3VZWGFWemdidzIwaGF5bmxrRUJRdTA1cHlC?=
 =?utf-8?B?RkV0ZzVMV1BtUnRKNER5QzljM04zY2ZJN1dCUHZkMFFNSDhJV3A3THZPQlJM?=
 =?utf-8?B?eTkxOUNHbk1OZDVXS241bDFjU2VDUHJHR1UxVzZYL0dGRmhnaktBbGxSMDgw?=
 =?utf-8?B?N3RyK1hKWCtTQVUvUmsvZjFSTGI1KzdtRWVERFNKSmNRMUxFdFNYMEp0dmJi?=
 =?utf-8?B?d1k3YXBRaUZ6N3VQYittdS9DNGR5aGZtY2hoRXBqK0o5Lys5RkJVNzlIODZE?=
 =?utf-8?B?ZUZ5VVhKNnNBVGJSNDR5aUdvcHBYdWxwTHBDYmM0ZnZKSGRHais5QVdpM2tC?=
 =?utf-8?B?anczYnRaYi85RmE3a1c0WDM5YzJJTEhaRHplRUU4SHFpNUhpUVJ3QnpIdlR5?=
 =?utf-8?B?NE9OQ2dqcWdiK0ZHRFpJcG83K3lzYm9WNy9RZG9jWmdsZEJvNFM3YmNlZExN?=
 =?utf-8?B?ZFhLZXkyK20rUTVHRGJxTW5FTVBYbjZzV29RVXJ2QXZ1ZEpuaTQrcVZ0S1Y0?=
 =?utf-8?B?UC83UDVVSzdSdlA2U2hvazk5OEhLdzZwTW05YnhRQmpNQTM3enk0T2RlWXZE?=
 =?utf-8?B?U01Rc0ZEZTZYMllhU3NwL2NKL1huQnlCR1ArUTFCY0lISzhpZ003alh6YkpH?=
 =?utf-8?B?a0pQdXh0dVJ1dEp0RlREUjRMSy9YWnJtUjBycmdUQ29qbFpId29JaDRuR3pV?=
 =?utf-8?B?c2hoeEcxbXcyaUNiV3V3NEpmWXArZVF2K0pJUjlScldaa1B0cXlzd1FFMldS?=
 =?utf-8?B?aVU4M3B4enpxYkt0TXdDbGpTeU9JeUUxV3FrU2VnMjBoeFpBQ0k5SFRndGNP?=
 =?utf-8?B?SVhZZlFsaVREY0VWNXVLbzBVLzhldFppdmJZNktFdHY3dzZKMEs4UXVnZDFw?=
 =?utf-8?B?bHo1dmRGUUVBR01Hejgza3M2RENaTzY0T04wQ3lZTFVtazgzeFYxRjN0bm1F?=
 =?utf-8?B?aXcxaHRpUk5OSHgvRFFuU25xNTlUMGJiRSthR1V0U0MwWDVxSUtXUkFybVVT?=
 =?utf-8?B?NXRxZ3RLN2djVDRiMHp3UktWeUdkWWNhUkJDMEtSeG8reTdNT0xPc1lkV1Rl?=
 =?utf-8?B?dUozZ1hIcVdiWExiOWRjNnNVNjBOdkh0NUQvSnhSL01CYTN2RHI0RzFQbFB4?=
 =?utf-8?B?SW8vQ1UvdlI3VVZYeWowWkg3OGZWaW5GellqaDUybkhJRlB6VUg3dUxrQkFG?=
 =?utf-8?B?VUF6Z2QwVkJ4bjR1VG4wRVJXRUkxbHVDbXNiRXBpZlN0ZWI3M2VldHhNSlZm?=
 =?utf-8?B?L0RVUE4vUTFoV0hIWVd0dDErZ1JPS1hLNGdkQWJqckdSaFlwQ2VjRzBZekNh?=
 =?utf-8?B?MlZRSGVXU3FDcjFQc1NQNlRWMDAvZzk2S0RjTTRHdGpJSVdNaGJOWGNwZFZ0?=
 =?utf-8?B?U0FrbmJRczJ6Q3hHdDJDUnhZV3Z2aHk1QTVTcmQySkJsNk12bHA1S3NrUThv?=
 =?utf-8?B?WTdNUTZpajBmMml5YzloWkQ1VE5LK0k2ZDBtSDJvWEZCVmZwa3VKUFRrMUFi?=
 =?utf-8?B?UzZXbVlPZlVSK1JNaWgvMnNoU2N6SGdsOTROZjlSb2MzcDdrK3Nia0xiVVJa?=
 =?utf-8?B?NzZ6a3FvUHZ2VEI0ZVRJUHg1dGtHdXowRjVabm1kU0t4dFJLcnBhUzFoa0lR?=
 =?utf-8?B?M3VseHpYM1lqRTU4UzU3ZmhFbWYwem5jN29ycmE3bjlxMmpvNkJQbUplSzAv?=
 =?utf-8?B?RE9rcVEzOUhKOVlvM0x1VHpOTFhKUlZWUWwrWEdUKzE5UjY0WnhRTEhKU3px?=
 =?utf-8?B?aEk5S2RLNExOSjFKMmVPK1B0TnN4dHh5TitxdDlJRWIrQ3lIa0dFbmJjQ3Bh?=
 =?utf-8?Q?WDxlpAuln07c2fdxzmI0Wg+ZB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2175317-affa-45ef-866f-08de1bd340c7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:52:07.4245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iGgtxIZ4bsqYRfS0EjRheSLRdsG1gN+U5OQRH/8KsuZh2rznN/kdSk32JVnSTEvx2t6RfBobibPIo6zNw1ixA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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

On 2025-11-04 12:06, Alex Deucher wrote:
> On Tue, Nov 4, 2025 at 11:46 AM David (Ming Qiang) Wu <David.Wu3@amd.com> wrote:
>> unref bo after amdgpu_bo_unreserve() failure as it has
>> called amdgpu_bo_ref() already
> The other error paths need to be fixed as well.

hmm... do you mean "map_error"? it has the amdgpu_bo_unref() already.

David

> Alex
>
>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 2aeeaa954882..99ae1d19b751 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -386,6 +386,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
>>          amdgpu_bo_unreserve(queue->vm->root.bo);
>>          r = amdgpu_bo_reserve(bo, true);
>>          if (r) {
>> +               amdgpu_bo_unref(&bo);
>>                  DRM_ERROR("Failed to reserve userqueue wptr bo");
>>                  return r;
>>          }
>> --
>> 2.43.0
>>
