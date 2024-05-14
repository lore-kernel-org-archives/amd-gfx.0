Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8BFC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 04:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 901F010E235;
	Tue, 14 May 2024 04:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OmfT94KH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D3D110E235
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 04:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf/8Ph84byTPlvPN3ImtIj806/3Jgk5hrDjwzDyoxWOA9V4htfeeuIwFEeZWVAU939OSzuN1tTVFOkvRb+CKjE8WcoPrP2nSjgk/wXLY2mcYeQa7kaaW9GvWJM2jVzCUhUI1mpPpbTZNLpFBCVwOniP0bzlMLe4GgVlHaN5WPZVAYARsqpkxPedSLoeuFI7grbj8Y3O7lOBDuUpVoiWy8av9L782dTyqt0pkMJOC8KiPcqVkzdCOgFsUYWeKDa1n4riWI4Se0ITUb8BG/UeoR3x8ltwzjWJh2GPkW/0osGLRu+9AyXHciRSh1aT/feseQIXJtqT3lphxlyvkan4Wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg0P60ngn4qcSpNWngWF2z3107r92K+2LXwNBkxnOg0=;
 b=DZvyWA8X96rmZS2h2Ri2A/Ir8xqWBaBVr9UX/2dW4Jx3V6iirUi0FT2Fi+VWiqZCOyXD3tJIqPINZJ9F5dGIGB+jeAB0+VoNL99KOzSDsAIRp597yLdY+XImgLdf5ml5TENwqgcZ06e4vvhBXPPd5evqch7Vbo1jqSctIv1ZA7TbTjyRKUOsYXAKtjNCNnQbJpT6IMtY1VCmIdFsakldXRpPe0Ed5+VcEeydYZNnA1Vam771w+LSuwZVZWdFcwPF1jU5vTpyeBVdlqz+OMcYVU4bSQNtYNdUIQIDL9InZrHmbOht63B7+4c2FDbQ0UXE0+ZVowVsY1tXtey6XqYsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg0P60ngn4qcSpNWngWF2z3107r92K+2LXwNBkxnOg0=;
 b=OmfT94KHSUcRWEZPk3mi69pYOVQe/fBKtU8O9PL3EuVfx1S9X8Doq0nEoVhgFYF9poMn2tdp9Ixfc4SUX7bC3rN761pMhX+jRzSkvqEDKAB3N+SIzMFgCtLyti4cc0KVhcZiWzVHX++YBc/bi9lTEO1JEGWeSt7G/a3Fa2IjP1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 04:18:57 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 04:18:56 +0000
Message-ID: <b474379d-cc71-444b-9f5e-4e19c0d67426@amd.com>
Date: Tue, 14 May 2024 09:48:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdgpu: Fix null pointer dereference to aca_handle
To: "Ma, Jun" <majun@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20240513085616.584249-1-Jun.Ma2@amd.com>
 <20240513085616.584249-3-Jun.Ma2@amd.com>
 <PH7PR12MB5997912FE549D642FE2AEE5782E22@PH7PR12MB5997.namprd12.prod.outlook.com>
 <d0f00c65-0d80-4722-8d37-c856fd2bc003@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <d0f00c65-0d80-4722-8d37-c856fd2bc003@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f780f43-ad72-4da7-dde1-08dc73ccf8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWpWNU5YQTJ3ci9HTjAxVDN2bFRrTnVJaWhVWTBrM3RrME9xNDBRY3B0N1BN?=
 =?utf-8?B?SHphdWk1cmIyL29pMk5GWjZUa3M5em93V2Z4bnhiWnU3czV5eXVMSGhlK3N0?=
 =?utf-8?B?TmNwbWR5OWU2YThqSkFZRmQ5RmRPcFBUN2tZVmpLRVFuUGVybmxyM0N5RWpL?=
 =?utf-8?B?TFNFZlc0MStKODB4NktESVFDMWF6QzZMTnMyMDR5WWQ3d1Naa0dnV0ovRzVY?=
 =?utf-8?B?N2YwUzFLQ3ZjZmJSWlZIanFVbzdHVkg2cUFMbnlvS3pGZG5vUXBrYVRiR0pB?=
 =?utf-8?B?bTViUFZ6MENLNGc2ZVNPd1l2aFBSMXFnL3Rna1daM3VCOWJCeG9GeFhiWUVm?=
 =?utf-8?B?b1Qvc00xbGNoVm1FeW5XTXhhNEZtMzZkbnh4ME1hU2RhWXdUTTgyODl5endv?=
 =?utf-8?B?blV4dENLWWxqVDF4Z0lySjhQUE12elkrUlp0YUs0Sk01ZmRUL256cGZmcjd5?=
 =?utf-8?B?YWw1cWFFcU9uSFRHdkhKWVdwcG4zY2M0VFc4ZFVVYjJFT2ZMaWpaU3dCTjMx?=
 =?utf-8?B?elBsNXVpWFczTEZGZVRtbFArUkZ2K3VOV0hJL1lOaFM5b1lhY05vTDVOYmNQ?=
 =?utf-8?B?SVZKdWxSL2Ixalk0VTdwUVpMK0JLcXRrL2o0ZWFNUnVicnluVHVqZEUzVjhR?=
 =?utf-8?B?anpYam5JV3FCMVBaNEJvOHJUdmc1cUQybmFQTjRuUHRzdWJMa1JQdzVpdktt?=
 =?utf-8?B?YlJ4bHdHaER4NzY4VVE5Qzc5Z094VUM3cldpNTV4MXpVZVlldkYvY1llTHRB?=
 =?utf-8?B?S1ZBQ0JmV2F4ZEVBdHcvV2NzZnhNc1ZCYk11ZVlDZTJ6UjFwNmNRZXd2Q1Z2?=
 =?utf-8?B?UDQ3a3duaDZnZXRiVlBZaXhGeHpPZ2JaY0gvUHNVZ3RIMlZISk9mV1d3cFEr?=
 =?utf-8?B?NEwrbzV6UEFMLzRrQ3YyaG15MCtJWjlqYnRrUWxGOCtVYjZsbTFhUUdqZHgw?=
 =?utf-8?B?aGd2Vld4L1RMWDVVZDFia2dnMzNodUpsYmZ3M05YU3N0ZnFsNWdwMUhlWm5E?=
 =?utf-8?B?dUQ3VVF1b0hVeGM2Z2l1ck1ZU2ZWd3paTlZ4c0g0Z29USTZuMUVRQ2txeC84?=
 =?utf-8?B?cGZHUE1HdG80WjVySENST01EMlQ4SXNFbkxXQ3FjWFZ1RkxLdmhDdUc4TkxF?=
 =?utf-8?B?VTdEM2pDeHFvTFZ2cXNBUUJBRlB4dTZ5em9zUGhXWkRGZWdBeC9QMnJwekJx?=
 =?utf-8?B?THRLa1d6Um0ySmZNd1hKRVVRUzY3TUZuTWI5Z2Z5cG1nOUFHL203QTVxNnRT?=
 =?utf-8?B?dnpibnpiU2Z0c2gvTGxPd1FiWTcwZ0g0QnZSakoyQ2w0dVl6eER4ejhpeFQ0?=
 =?utf-8?B?MU1xdng4QW1EY1FZY05EYWxxYkVrbElHSzNKNnc5NUYzblpGdFdRd3lrUnRl?=
 =?utf-8?B?NGdwOHJNRmlZWDdZNExDaFloeVl3K3Q0WEtKK0szR1lsWmhnSTViTVBNQ1FS?=
 =?utf-8?B?Rk1rOWlHbHMyUjZNd2JSWWhHcTFHNURWVHZUNkxEeTQ0UnN0bTFlRVRrWUxD?=
 =?utf-8?B?VjZNUHUyVmpxMFBqMi9rY2tNR2lwejd3QTVkalZUNDlFc2RBbmZFUHd5OG5q?=
 =?utf-8?B?WlBDbm01RW1MdmMxRGNPQVBreVF0cjJ0UGNGUTRMNzFtVWc5WlBWVTBVVE1G?=
 =?utf-8?B?Y1BqMFAycWxvVWJPMXhZVW5wOS8zV3h2a3F3Vm9jZ3FpN0xvdW51dkpHazJl?=
 =?utf-8?B?S1M3UlF1c1NLNFRPM2Y1NDZ6TVl6VEl3UHBGbFRhd1h5VmM3dmdTc0V3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTM5aHBQaS9VWkF3bVpLNTFudlFjSjNPWjlXUkFHdHhkRk82N2hhZWtpWERG?=
 =?utf-8?B?ZGdEc1dOYzV4Q1JhaEE3QmJTTjdqRFNDVnN2eWYrcEtWQm9Ya21QK1Z3MXQ4?=
 =?utf-8?B?LzVHa1paSDRjRFRvc1FucURMVlYxZkFvc3haK1JrdlBweTJURXZ3Y2ljN3gz?=
 =?utf-8?B?SVdWTUNaNHdlTHVwSUUxWnNyMUZJRWVqVHZuN2lPYm5sblQ3RFB1dnBQeWxh?=
 =?utf-8?B?WlQyVEZoYTlJckVFWUN5dHNQbjhMTW5Sb3ZETW9QYXFhWUM0bktaakxyRUxZ?=
 =?utf-8?B?c1loUGdtdjNlNUI5eVhIZEVXdzRmUGM3RnBMTmlBaUp6bVdEcUhoSnlEZWJw?=
 =?utf-8?B?M1FiQUNRd1FRa2pQMlhpK3JHMzlUMUw0bEpXWGc3aVAxdEVuM3hhdFR6Rk8r?=
 =?utf-8?B?cUVtTUhHeE1jSE1lQlBDeHB6cllRQ2ZCdkZERU40VitGbUpTRDR6aTNLQlFo?=
 =?utf-8?B?OHN0OTFIa2FmRjlSUDVlT3dXZXdMS2s2dmRRSEgwZ0pJK1dPTFV2NzBUUXVt?=
 =?utf-8?B?cUEwdE55Z25FOXo0MkNYQ0p0aDdoZDg4OVJpekVkNllhTGtUSXZOamJIa25L?=
 =?utf-8?B?STcyT3dHSS9iYzB0V2l4eTJQQ0U4TzBlQlN2KzI0OFFYazVkWnFZZzIvYmR6?=
 =?utf-8?B?cUlTQ3VjNVZBZ3QydU1rNE9CYm9KRkJTWHY4RkNjTStadVdjMVBZODRiRUF0?=
 =?utf-8?B?ckNYN1JrOFNaRWNweldZQk1KdHNZcGtXR3JrRHIvaVJwYnU1TjBhRG9vUkdF?=
 =?utf-8?B?Z1BZRkNsRE05TXp5RU1BRExyVjdDYzg1UEZrV2t2L2NEelplayswZkJNcVdL?=
 =?utf-8?B?RGFpTkFyRzhKdUFrWXRORTZzM2x0LzZORlJsY2pNMG5Sa09tVkhJa0dwQ1l1?=
 =?utf-8?B?UGxtc2dvaDNqQjRIdmwzVmlCd0F6N1lEYzR1a3FEd041OHE3WTJYSXBlcTdG?=
 =?utf-8?B?YjRRODBtSDQ5cXRNQ0kxSXlZb3JDTFNrVzJZcnh4NFgyK0I2c2ZMS3RHUEc5?=
 =?utf-8?B?V2RBSnRnckZCYitFa0lZL0wvTTViN2F0YklKOWgwcm1GQlc2RVNKczJVamIr?=
 =?utf-8?B?SUZjWGlNLyt0ZUo3c0JMVHJ2c3ZDWUxkMUtFblNRdDhYcktpeTJpc2hjMEFP?=
 =?utf-8?B?WGtMWjVLdmFpMlZnUHVpTmxiQnRrTjRsMUNYekpKS2dPTGdwUmJ2bjdMYWdw?=
 =?utf-8?B?V3hpd1ppOHdkeVd0YXRWUVRWRmNLclJNbkRLdkFVOXZ6bE5Od25POFFWUy9q?=
 =?utf-8?B?M1lRVXB2T3dFaDZrS3VGa2NZdjB6aUplWCtuMUQ2bVZnWW9SLzc2Y01sM0hv?=
 =?utf-8?B?MlJEUjU4VU1kNzY5NHp5d1hIT2Nsb2NlQlcza3ltT1FxM0U0WXl1bm1kaUFH?=
 =?utf-8?B?M3cvK0d5SVhlblA1cFZXUG4zd0s0OEdyTkdaSkR4N1dBakMydXVhV3NYVW5J?=
 =?utf-8?B?QWhPMjBwVk9waHhXeVozV3VZeTVWQmRwT1lKYUpUNk5DbEY1SzBwL0lTYXNN?=
 =?utf-8?B?TFNBNHYwQml6S05ma1Zxdm1nSDZUM2ZrTGcyRDRwYmM5LzZWNGtkQ2JhTWdv?=
 =?utf-8?B?bnBtWkl6VFdJVUhHdVQ0dUd1OHM1bGhhZTJjZlZ5aHJObVlOdW4xMi9rd2Jy?=
 =?utf-8?B?MUhaaWZPZTlwc3JhSXEzdjB2UDZIb25SQk9CZmhnZVVUcEFORDJ5K0RZZTJl?=
 =?utf-8?B?VlJYMHBsYW5rVnVnMVBtdDRGU0VMUFgxUGFOTmJ1b0s3czdlaU0yZ24wdFBu?=
 =?utf-8?B?V0J1c3ZjbWdJSC8ySGdFVzc0ankrcEQ2MFJaSXFHcmFXZkRnaHJXQ0U1TU9J?=
 =?utf-8?B?TVhncDAzU2J4Z2p3ZUhlYmpmNXJPMFpZeThSS0JmdkhHUm5ML3paZnBuTGRm?=
 =?utf-8?B?UlVoQXZoblk3am1WTGJUdGxoUHJJR2JiTkNrZ0RvM2ErV2JVOVp3WjFjMllV?=
 =?utf-8?B?dmRWcGRtQ2VObVB6T2pQTjRVdklabG5UM1Jqb3lMMmpUZVFBOU8vcXM3UXZ0?=
 =?utf-8?B?NlNYZjJDSWpXbFk5V1cxakhMeWJXR0prTGZRVTNGMnZYZnhXSzI1Y05TRXNO?=
 =?utf-8?B?RDkyYmNvOUVlUGtqeEI2WExEcmVVcFlDTFYyV0dheW13OUtrTnIxNjhRZ2hh?=
 =?utf-8?Q?ddTMzONlbpj2cyG42eA9EK0yQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f780f43-ad72-4da7-dde1-08dc73ccf8d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 04:18:56.9106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTMOILow3yXsivVWUzh/1wR4K5MuHH0Ls1FWqRVaIXdJ+NoSQGfHrTXpefR1DVuO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703
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



On 5/14/2024 6:30 AM, Ma, Jun wrote:
> Hi Lijo & Kevin, thanks for review, will drop this patch
> 

In the original function below check is there.

        if (!handle || !info || type >= ACA_ERROR_TYPE_COUNT)
                return -EINVAL;

So moving this to a later stage is still valid.
	struct aca_error_cache *error_cache = &handle->error_cache;

Further NULL check of error_cache is not required.

Thanks,
Lijo

> Regards,
> Ma Jun
> 
> On 5/14/2024 7:13 AM, Wang, Yang(Kevin) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> -----Original Message-----
>> From: Ma, Jun <Jun.Ma2@amd.com>
>> Sent: Monday, May 13, 2024 4:56 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
>> Subject: [PATCH 3/5] drm/amdgpu: Fix null pointer dereference to aca_handle
>>
>> Check handle pointer before using it
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
>> index 28febf33fb1b..e969a7d77b4d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
>> @@ -279,7 +279,7 @@ static struct aca_bank_error *get_bank_error(struct aca_error *aerr, struct aca_  int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
>>                                    enum aca_error_type type, u64 count)  {
>> -       struct aca_error_cache *error_cache = &handle->error_cache;
>> +       struct aca_error_cache *error_cache;
>>         struct aca_bank_error *bank_error;
>>         struct aca_error *aerr;
>>
>> @@ -289,6 +289,10 @@ int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_in
>>         if (!count)
>>                 return 0;
>>
>> +       error_cache = &handle->error_cache;
>> [Kevin]:
>> The above code is always return non-0 value, right?
>>
>> Best Regards,
>> Kevin
>> +       if (!error_cache)
>> +               return -EINVAL;
>> +
>>         aerr = &error_cache->errors[type];
>>         bank_error = get_bank_error(aerr, info);
>>         if (!bank_error)
>> --
>> 2.34.1
>>
