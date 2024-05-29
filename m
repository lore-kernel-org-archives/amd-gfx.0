Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D559C27C43
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 13:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0DF113AA5;
	Wed, 29 May 2024 13:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qO9Ur9HO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A34F113AA5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 13:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK8YaF4iT26Rx8XMcZetegGfGF52tqPTEFgpe4dMIfQHij9FkpgW3FmhBj6aG856zNduodwNWI0nFsYDQ0nR/yYIz/kx2Ynm9HsEkMAA1xcgyYhD7sUrV2uMLV7dsic6204NxcNkMqwsH/iVd0/WJW7A3tQvYpgN23VAJYo165YOcMQ8rrB1bQ5Y5FoeEjrl2fyCTkpXK9+t/93OM9q4RTEQgbtYJ2NeC+SX/MRqXKdDrGWPVwtR5+1laDSR0tOf6kqphtUsFvJvRHG5+yzqoI0rJ5xt2ic3fDqGfs3Y07WZIKwCQ3qryFlNLJL58JtTYT4ucta2qZq2xvkx7E6nXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm5ZWzQQv3fi+53xo9+LZ2bN707xSVo2Nkd1wELioas=;
 b=V26duKoUR5W5IUP859KARgmd2YEOlqq+1xzgeXdwa0zBvXeJpeauXkoQSixRXZ9xhlUtYlOs7OdM7WrhmGWpd/d6KA4lJ9NO1lEizYLFmZZpbH3Vy1Sl6eISXtcmvAzwNGE97oo2l0FC0gbw7kWCWr+SS/QPGLHfj8h9d4Kav80JIsPmrJ9DDiOfpUwr2YDfPn9YemMLzrdxIyweXG/510fetzYg2A75fhbUNpeGGSRa+OhlwfokmEp8SqYW7dPi0cPgwRhFD7AtFM2Gr2cht0e86R2f+X7xjdKiz1Nqcz/n7QLwcOrV9CqKTmn8fsABFdms6x7cfy2nKUJd03mH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm5ZWzQQv3fi+53xo9+LZ2bN707xSVo2Nkd1wELioas=;
 b=qO9Ur9HOqbi3B7y/3m4y8ZVEAELEVC8xlwq/Hmhzj/HPCZWrO2beFQ9jrngJpQaGx87v6ayEur1+WEECHtFe1a/n9dapOsIJs5n4MSJLRHnKcrhp6mvNDPvHJsiMgfUUx8rmSvLM0Zw9bG5Xz0elUaxbdZL81uKQ+hcZstNJKzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 13:31:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 13:31:58 +0000
Message-ID: <a1e40066-f980-4490-a0b9-d8f3be34ad8f@amd.com>
Date: Wed, 29 May 2024 15:31:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
 <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
 <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0370.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a84e08b-e03b-4925-50b9-08dc7fe3b6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGVPVGdEMlMrRVRMOHRpcHZXeXhVV1R1SXlPd0tTYVVTd3FRaVg5RjNYTWpI?=
 =?utf-8?B?dTBHVWRWQUF6S29GeEtpL2IvTk1vVDZqcnl5TVZSbFZZNEFKT3BOUlJLUEQv?=
 =?utf-8?B?L2czMlZsdTAyenJjQjdBKys3U2lObkJCWm5oMmplekJGSWZFK2dnQ1dwbjk4?=
 =?utf-8?B?RldaWHFEQm9TUWVIYWRrbkRvekZRMFFoWUJTQ2JiSnlRSlN6cjM4YnF6U0VH?=
 =?utf-8?B?aDN3cGZEWFl3SHhpaXR0NkF0SWFOWTQ5Ti9ad3NmbGFPTDJla2JMclNDd3dI?=
 =?utf-8?B?YVJVYTFrVjNwRUtHb1BzS3hESk1UWVNXZWlhandRMThRdmViQ3cwY1FoS1ZW?=
 =?utf-8?B?OUgzdlR1UDdaUnRrTnFJeEtNNzJIYVRaVFh0ZXhxOFFqUE1ZSnB6R2dWS1JG?=
 =?utf-8?B?V2N6TThYMmVPR0Z4bkNaYWkzMXF5V1h1bEhlMExGYVBnQm94UWdSeFcyL2Jh?=
 =?utf-8?B?c3N4OHlPN0s3N2FKNWJDdTBBWC9lL0JhYlk4THZPaXRrbnVhRkVoMHoxWE56?=
 =?utf-8?B?WGZ1T3U1OVl6ZzdBamJaSkFhRXBkZUVlY0FpVmVtQ3REZnZzUnh4d0tTSmwv?=
 =?utf-8?B?RzRROW9pOUlXTGNBU01NeFNnZldYREtpdUhEUWFDZFZvWGNodHF6a2J1Uy85?=
 =?utf-8?B?N2pMcUN4VHFZVUFrUG1lNnJkMjdNTzZKWE1IU1ljMWxQSlQ0TGdtaW53c1FE?=
 =?utf-8?B?QkdwcC9vLzEvWnBqQU9KVWJnMFlaNUZhVVdGZ3lZRWhQZWdoMm1yR3ZhN05z?=
 =?utf-8?B?QXdvejhUZjNmakFPRFVsM29pSHBxM242MHR3dWRXbkhoNnBseDhoVmN4cGx0?=
 =?utf-8?B?ZnRKZUoyYW5KcDNCc0xXencydlV5ZWtQdzgxSThIMElmYlFzNHlRYTJJWXoy?=
 =?utf-8?B?WG0wU1l4N0FTK2xpQWdnNUJhM1M4UkdTK1dqRkhVRy9jaUpIVnpXL1lXVHdL?=
 =?utf-8?B?cjE2ZXMyWFRHZW44TWxvZGJaSEVsT2JKWXN6Ympqa3V5ZFZwUTdUUmpSL1Ju?=
 =?utf-8?B?ZkVYZnFiZVpzOC9MWFhvOVNuTkNtaS9JUzV0L2lGU3FMYVNKQjZOOVJ1SlpJ?=
 =?utf-8?B?SWkvM1k0UmlBOFJBbldmM2tEYi9TWEU3bEpJYmxMcHZjT054cnFSclBKS0Iz?=
 =?utf-8?B?MlFlcGhZWnE1YkRJaEZZbUh5cVZsaTVtSUNnYnJ1bnFjR2tCc2hqVDVPUVpv?=
 =?utf-8?B?MUJ5cnY4NHE4d01ad2xKa25uMSs0eVVHZkdFUjZ1NDRVY2doaFoxNGFBVUFp?=
 =?utf-8?B?a0VGSk96NytjdVZyWlBTL3gzS2VFU0IrK2Q1WUU1OVhTRUJKZG5kQ2hLMEc4?=
 =?utf-8?B?ZnBMc1lKM0IvREFxR1JhNHVoaEVtcUQ4RmQxb1hiTUQyWGc3T0FRZDhBbits?=
 =?utf-8?B?dmFLT0pRb2szak9UMURiYkNLL2x3VkI3aS9IWHFFNWxub0hib3dyWGpSQm5K?=
 =?utf-8?B?ODJyN3dqRlFCZEtYRml1MnY2c2grZUZIRm5xeGZBSEQ2RWJUVU9BbmhROWx1?=
 =?utf-8?B?OEcrdU1XQmRNVVZISzg3VTBxYm1wRFFMR1hycnArcDhINFJxSzZqeStwN2lo?=
 =?utf-8?B?M1RvWTdqYy83Rm5zRjdFVTRQSk0rZ2ZkazRTdkkwRHBFTENhSkx5TUMvRnhh?=
 =?utf-8?B?cGE3NEs3MmsvNTEzMUoxQ29VVEltYVJ0YUtEbmVpbmRMcTAxaTU4VW1TeVg3?=
 =?utf-8?B?UXQwdFZ4RUc0MDB5eUs1WnFNelRJUEdQa1lPRkZEMmgyN3phaXcxM2tRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3NPaXVCQVcrdzVkUVdLanhwd1FKa0cvTVVQLy9Cd1V2U1Y4MTJoYjJWbjk3?=
 =?utf-8?B?RjhjRnJwSEJGdmtqd1grVjdUWVFVZHFkNVcyODUrUHk2RTJKRmVpUzR1T1lZ?=
 =?utf-8?B?N25aTTg2TmJaZTRJQyt0Nms1MjB5Nit4T0ZoOG9jSk1oSndETjFrdEZTZ3Vr?=
 =?utf-8?B?eDcwQXh5clNVQ2svM2diY0FOR3VZYjV2N0g2K2tCR08rME84VEFET3ZPd3Zt?=
 =?utf-8?B?OS9NaG5rR0lWYzF5cW1DaDNkVE01KzQrQ3ZVNm9Rd1Z1MVhBUGNmMEgwNnZW?=
 =?utf-8?B?WjFFWnEvbzJoeHpmNjYvSUFCenBvMnd6RUNkdExmcFNkYXhIc2J2S2Y3cWlh?=
 =?utf-8?B?Z0JzTXd2WjhObHBXVTdmMVBQYXlCZ3J2U1Z4R1BlbWM4bGdCazFBbENsV1FP?=
 =?utf-8?B?eERZdHIvMnNmQy83aUdZaW1tRTJBaVJ3NStLRkZ0L2pIeUxOQTN0dUVJZXJw?=
 =?utf-8?B?WDBOZXRyN0dyMWFkRi83VUVqdnltQUZVNGZRcHZuRDRpVHdUK2F5SEc2ejdG?=
 =?utf-8?B?bWJoMjg1VEFuWTNxTlRkaUFlK0lYOTlZZFI5cm9RNFVyZGNZWHRFWXN3K3Q3?=
 =?utf-8?B?ZE1vY05LVzA3NTBRZnYvY0Y0cnl3MWhlK1ZUaE1VTWpDVTZvcUNNUXhQUStE?=
 =?utf-8?B?SDUwS1dWb3BJb3oyTHhvY3kxZ3gvWVJKR2hGVTEwc3FrZk5JUGIyT3pJUWF4?=
 =?utf-8?B?aytpNVZneHZ0WEtCQTd3cFFrUnpkUXRUQkNTOE9yZy9HVEV5YjhMRWRnUWxp?=
 =?utf-8?B?NzY3T01uN0I1bXFwVk1xWkxvbXRNSmVZWkpyLzV1bmN5Q0NhZDM1WVVVdVFr?=
 =?utf-8?B?aHNhSjY3VDhzaVpKRVphV2lCU3EvNVA0dCs2a1RPK0hSNjdDdGYvckN0SGtT?=
 =?utf-8?B?R3dER0tNNk5qdHMyRmZwRVVncHVxSE5RSzRWN2ZFMUFuVWx6SjBMVHpmVFRX?=
 =?utf-8?B?OXpBclVOa3QwT0VTcE40QWROMTNhekw3dnRRelNHK3h6OWpOOFgwdjFwQ2Vz?=
 =?utf-8?B?NHR4Y2J6dUNLb01DQmZ6cU4zaFJmVjJWT1pxTUQ2YzRJOVNWOFROS2hySW9H?=
 =?utf-8?B?dUFyc2Y4WkFTSW91ZWtYN2hwWFg2YWJ6NTFwNGtab2RUT0MrS0ZYd3VKVzFn?=
 =?utf-8?B?Nkl0aVB3SG1lbldxa1NIWG8yUnJZbHk3bnBsVkRYcENkbXFoVGF5bDluS2FF?=
 =?utf-8?B?ZzJjUXRXeU04dkM1eUJEMkt2MXhIQzZ2UWI0YjlOdzVZQlp6Nndjd2tVK3Fl?=
 =?utf-8?B?SmFoM3Q0NlBvRlZIK3ltZnNPZ2E1M2NGclR1YVZRRUFHcFRxcTBMcG1uU2hZ?=
 =?utf-8?B?Y2RoVWtIdFg2OXpsQUc1SmprVnRuTnpvSjByRjg2TTQzZyt3R3Y0SVZNNG5R?=
 =?utf-8?B?UFhuSExaL2VHWDVSeVBFaWY0ZTYraE11QTJndzVLcm1oRVhvMUVYS3VzdHRR?=
 =?utf-8?B?eVVnL1RwM3p4VjBVY3BQV3RBcjdmditTYkV2UWdCTWlWYlNJc0liZ1FrdWpH?=
 =?utf-8?B?OWp2c2NCdHMwL1dlby9FSllFT00yYS9vVzl4c0tHbEExMHpZcVRlamtFRlJt?=
 =?utf-8?B?L3dCZ0xuczl2UFhLdnVLZ01tQ1JtTWtveUFnYVMwUytXOXJ5NFRNbzloWE1u?=
 =?utf-8?B?N0FNYStpRkJqRVlaSFFKYXNNZnd5WnZDVFRVU1lNY0FMZXl6Q3BIS0F0OFgr?=
 =?utf-8?B?cnZsZGkyK3dETnZhWUlYVnh4eTBPbER6VjRIUzU5Q3AzQ2FQb25NTHkzd0Zn?=
 =?utf-8?B?SlJ0dVd1WFgzSFhxbHZuQXRpMmNqM1JXb1h1VE5OME1LMHIrWDBmN3pRMUt4?=
 =?utf-8?B?ejV0S1UwMkpuUkNObDZRVThHYjJQeXBqTkJ4RHNzbTV4dGkySDZub1lMc0xG?=
 =?utf-8?B?NUIyUk8xL2JmR0hpMlF6eEw4ZVRzV0NSVHVnZFRHWURDSjdNLzh4YkdLTTVi?=
 =?utf-8?B?NzRkdHNPUFJldDZwSGcvcXlQbjh1SUNNYkNYVTZ0d2hJaWYzKzdDQzZpS0tX?=
 =?utf-8?B?QUNvbjFlRDlFRklVa0pTcU5JcnM3K3hqUEtZV2F0b0I5aGh1bUVjYzRrYTBq?=
 =?utf-8?B?dTdvL3p2RnV5RHNsZThEQUdwSTNsVy9RQzhaQ2kzSlpvUnN6RmFjNHF1MVhX?=
 =?utf-8?Q?TdADYnkZPtTkmgcSwW3tUwAWo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a84e08b-e03b-4925-50b9-08dc7fe3b6ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 13:31:58.6602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29cNQ+2ifrU+kR0eFXl6JbKbj57UdzU54rk9MFo76J7R12VXzYcn5LdErlN4SC3V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
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

Am 29.05.24 um 15:22 schrieb Li, Yunxiang (Teddy):
> [Public]
>
>> It's perfectly possible that the reset has already started before we enter the function.
> Yeah, this could and does happen, but it just means we are back to the old behavior. I guess I could use "can I take the read side lock?" to test if the function is called outside of reset or not, would that be acceptable?
>
> So like:
> Int not_in_reset = read_try_lock(reset sem);
> while (...) {
>    if (not_in_reset && amdgpu_in_reset())
>        break;
> }
> If (not_in_reset)
>     up_read(reset sem)

I don't think trying to add some reset handling here makes sense in the 
first place.

Part of the reset/recovery procedure is to signal all fence and that 
includes the one we are waiting for here.

So this wait should return immediately in a reset anyway.

Regards,
Christian.
