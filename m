Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C71E9A053
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 18:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D5510E72A;
	Thu, 19 Feb 2026 18:00:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XumOCAxQ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013068.outbound.protection.outlook.com
 [40.93.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA15C10E72A
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 18:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vv62+spgLSwa+s/6lLkODgqnuYDkZXIvuAGB8dW0IViRr4kj6Q4+L/ysxPeDkJ8CcN1MxOFnPWL0/I0Cb7fzxuBN1KTGRgojBPUuZHOAV5sWwW5qPuFV2vHCKf/1niCKBb9UxcalL9LyYwqlKszshzVvTe8s2ZfzRzz1svQEGdl4ZXUhUOPef/v/xcgSlplDjZAWYp9QFHWJCZa1zQu3l3Yn9sZ9PUZPC0vZfLS7TPzGx97/OgrZbN1l88WTm3wYPfaYgsqX0J9//AM8n8DHPx+xUaY1Ke3VT3GIAqKpGgUwv+utnKUbvZYKDtyjZ4TRVuF6A+GfNPkgxc5FxEJoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6CdVJlV8GjuMlVjaOnGrVf5vPVy+5uKXOb/mzLL6is=;
 b=G95UBg4nmUT+kzH2q73Rc+MezNc7U5qCjUSPi4fLXxvZ9oN0mbAqek8eDZocYdoUSbwCRxrXd144OCS9yIq645e0VXSveDOUazjJuAooP2KUiUmgDHaI2rbw7u+sEhWQH809+WK8mX3b+4vA1TORmDUTVS/xuvmToaBrfGq+X9OgMG9u1FeziBZqd58o2dKiCLFvv3Z2Y7PwlVRxapFdxFW9mGqcMbmEzFk+RdU28y7igfii7/D2l2Jyum1QkDOGDFYST2m4j7HNf+t7Km/xk8bfvAUXYGemORLGNZqjcXB7D1t9tvK0UIh0fT58nJT7qLdwlnS3JbWSRZSO8T28kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6CdVJlV8GjuMlVjaOnGrVf5vPVy+5uKXOb/mzLL6is=;
 b=XumOCAxQ97vJLI7ahtOM8cD4Ovkw07kgCBUm8AUF7JbeTxJngEkKOfmegde/WqQr01T0vZvslU2vq9TEhgTBmIW6uy73Kp+/GFZkKHwWROXpk19aSyEIQ+9uB8+vRYbgzshGQ4c+LVUwDus2Su1RN8fCBWKubuQNaU/RRkBrrZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 18:00:43 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::d843:c83f:a6b9:ae51]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::d843:c83f:a6b9:ae51%2]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 18:00:43 +0000
Message-ID: <5427cf30-9c9d-4904-8058-3a6c9785e696@amd.com>
Date: Thu, 19 Feb 2026 13:00:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] user queue support for VCN 4.0.5
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com,
 alexander.deucher@amd.com
Cc: leo.liu@amd.com, Boyuan.Zhang@amd.com
References: <20260210214729.80964-1-David.Wu3@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::25) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 60eb6988-b594-4c76-2463-08de6fe0cce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTlVbXcvazE2anEwamNKM2hIMmVVR3A5NFE2YjZreUl2enVXRERjTFRoNW9J?=
 =?utf-8?B?c0crTmcrU291NkFLeEo4eE1GbDAxc3pod3pGeFFKSEpPRWU4dnllellkaDU5?=
 =?utf-8?B?VjJRUDYwWTk2ZkkvSUZOZ2ZoNUVrbng4UWZNanNiakcwLzRMMWUrenhhMGtj?=
 =?utf-8?B?dVZiODJtWUVMaFR5TE82bTdjNWhteEFDbVo4OThpMFZ1WUpzblh3ZC9qRkRT?=
 =?utf-8?B?QUxEM3NiZ1diRnI5MDk2WnJNdGkwb3dTcm1udTJCendLSUZKQ1hTd2VaQmdL?=
 =?utf-8?B?cFdHV2xCcEk3TVhpRUhEYUpoVXJaV3dVcDFYUmhra29waEF1bWljUlFCRzd3?=
 =?utf-8?B?a05wQ3RLbkovOHFRWDVnNkZxamJLVGhnVEQ0NjBJaS9ZQnY2Z2xQcE1VNTd5?=
 =?utf-8?B?ZWw2eC9DY1pwQVlQaG9qcWtxbE00VWhJZ0l6emhWb0orY1dqZXZPRm9YcU1h?=
 =?utf-8?B?S0hnK2hLZVRpcFhLcHN3cjZLbGpkbkJ0TUNqNWJBNmh1SE11RlduWDJTTHBY?=
 =?utf-8?B?RklKSFhpaUR5RnVjTkpQUzh3WVRnaEFNemFjUHNVUUw4Uk55cE5tdUNPRWRy?=
 =?utf-8?B?dll2WGJwQWdCaVVHTFQwbm5EVXlYN2JhYlpyd1h6c0ZOL2d2SEVFc2dFWi9S?=
 =?utf-8?B?WFlvZ1YrREdEeHFydFV0OXd1UUJiSFlEbVJ2anczaGNsOUxUS0xSSEhwWUhj?=
 =?utf-8?B?OWZJc1RwN3R4YTVEbm93bzkwd01QNnRES3JmZWFCRXRyK2YvdGE2aDR5aFJY?=
 =?utf-8?B?ZlNGdEViTGgvVmZVcWdsZTVTYTlWNTZhVWJrVXpMUDJEUWYyOUhKWXc1T1Vl?=
 =?utf-8?B?bElTQ3Rud1pNV25nU3dhQjViRm1BR0psWE1MVFhOWTBkTXFZUVJSTW5IT0NG?=
 =?utf-8?B?S2lrMExkWXJsVHVUQVZob0NNUngyL2c3VURWcUc4THpPMU9mQm1CY3g4R2l5?=
 =?utf-8?B?L1Y0MHhJN3hiNHM2MzF6MHdUL1FZcHJsS0JlN2N5MkVoUGpiUThLTStvaUp0?=
 =?utf-8?B?cGVKdi9iZTJFL1pQTVF2YkoyWE5xMFpNNWY2blVRZ3ZpTjByU1diUDJJaGpH?=
 =?utf-8?B?MCsvQnVoTUo2RmhMQVhWOTJ4cVVYa3l1ZnE3N2xKOFVxVGdZS2Jtc2RQUmZ4?=
 =?utf-8?B?QVBBVXZNUUVDWThsZUU4MHBoUUE1c3JyRkRoZkdPdUlVMGl4ZURFZ2k0UEJ2?=
 =?utf-8?B?MEdmOC9seEZ5R3lCSGxVYTN0TjJzZlgwYWZ2U21kLzRndm51UGgrdzBoVU1s?=
 =?utf-8?B?MDhkM1pCQ05SQzB2Zy85dzFPbTFaWjZQK2U2OTA4amdXOE43azh0TUlPWVdn?=
 =?utf-8?B?VVNjMzZ5eWd5SWd1NEhBWjlNTGJnNk5QcWZ5WjBvYnJ4ZmdmYURlZEJYMGtn?=
 =?utf-8?B?bnk1VGdXQ2xrMjhYbWlUU0lRcU9GdXVSMHIrMVpVVUhUK0FMdEVIZFJKei83?=
 =?utf-8?B?cWxMMWUralRkRGY3enk3c082NVVMcTFDbUFVMlNSS0NFRXdvcjljR3RFS1Zp?=
 =?utf-8?B?VDZBb1JEVWNQektTUDNLa2kyalVySlZoZS9EVzM4V3BnbklkR01UKzM4T1ZT?=
 =?utf-8?B?WmluR0UxaEVsUXhzMksrQlRMT05ZNzU2WW9jM1lXVmdQVXk0dFkvb1dwTFYw?=
 =?utf-8?B?b2RoTW1MR0NRdFROaStpL3RFai9BTnBlenhMZ21iaG5PNkFLbnNTcERKekor?=
 =?utf-8?B?N1V4WEF4TWQ3K1NrdHZFY3hLcWpnbTRuYnlwT3dIblNhUjI3T1FoWW1la1k3?=
 =?utf-8?B?MmxOR3l3VEVqbnRoKzJ3SjE2VG9qdEZPUEREUnVtU2c0UXUxOWFFRG82OUhh?=
 =?utf-8?B?a2VjTVJxcDg0cFhRa1JCelUyRmFuYTlFZHE3b0huN0RwVzhaallxVGpmTk1Z?=
 =?utf-8?B?RVRaNnB5ZWZvTmRYOWtjU1ZMNVN5a3ZSM3djMFJvaEdWbUFqeGhaREUvZ2Vo?=
 =?utf-8?B?UW10Znc1SktjRnBZdmwvRWx6aXFSZGpsUWY5SHduS1pOeVJ2MUdxWS9kYTUz?=
 =?utf-8?B?Q2RkRnVXdXRnWGREK3hDRGxJM1hTc0tjRjE2TWdNRHRJbTcwaTl5YldqZjBk?=
 =?utf-8?B?N1EwRm5jaEU2ci8rTThFbEgrVnhzemVZQk4vaUU3S2xOMUx4aDVrQnh5RkdK?=
 =?utf-8?Q?u3F8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTQyd0dIbnkvM0ZtY2M0UWJSVjk5ZUwzbExWc29zN1ZxbFpTQk1LSTkwQlY0?=
 =?utf-8?B?VVI0WW5YSWI2bDUvcEM2TmlvR3VIM292NXVoWTNuZStLOHZ3ZGo3WVRRcEVw?=
 =?utf-8?B?VjhPTStwbnBUMU90WDdMbm1wa3lvQzdKbWJCeGR6N29yZ3lVam1lSDhjZFg2?=
 =?utf-8?B?SmIvMHFjaWNuMXJLVkFSUng4R2M3MzlzeXJXMWNxUVNCeG5hT1B1VFMyS3h0?=
 =?utf-8?B?TWZrNTVVY2V1cGc1QllYY3NqZlB4NTYzQlFjeDhsaXlGWVFMUnZ3TU9EU09o?=
 =?utf-8?B?eDFOSHBHazVmcFp3eEhoNm5ObFNDdEg5K201WDNmT01qZWF2WFgveWcxUE9M?=
 =?utf-8?B?Ry80ak5wc29YVkpmUE0rNFUzcGtUYUd4RW9odGFyelgyUTRVNjhmWHhhWG5R?=
 =?utf-8?B?WE9XT2lLUUlNNFlxUFRCU2pIS1VlNXlhUGdDVXFZV1JiNVdPN3ZRZWNaclNn?=
 =?utf-8?B?SEY2M0xOdnhJcVdjRTFKSzlOVmlJaTM1Mk5jZCtNT2tmenpYeWkrK3ZjT0hv?=
 =?utf-8?B?dUJXQlA5bGIvamdwTEhxU0xJSzhudTN5N3lZb2RZUVZUUUppNWtlL1Ftc0xF?=
 =?utf-8?B?S0E5MWwxd0NicGNlWDRWYjBmOUYwMkFQZFc1bVpYcVJLc0dqQ2xBTzJMN3FD?=
 =?utf-8?B?TG91aGpHVjFkanA3QnBZeGw4NlNaeHp4em9VUzZzK2V1QkNJRWlUaG9WREMy?=
 =?utf-8?B?UFBTaEJ2MklrdENXZXF6M3ZXM3NGdHJMWm1vc2pMb0svTUlCWmplWnc1bTlT?=
 =?utf-8?B?ZVFPMEwxZWt4RXpSSitVWFJ1SEM0ZDBjeXN4cGFlUlBsWjNBNzJzRnozd3FS?=
 =?utf-8?B?cC91NXZlUHh5VkN6cEl5eENuakRKbnd2RlU4ajJQSENrZG1DbWZldXY0RTBq?=
 =?utf-8?B?NFN6OERXR3lqRjFtVmNRTUNkWkgzTmwyWVN1RW9GaSs4ak5STThJbGxqeVRG?=
 =?utf-8?B?d1d0RWF1RlY5b2VOK0k2YkxyT0dqMnZHdFZXWlBXbkUxTHpTY04wRndGL2dH?=
 =?utf-8?B?dGtQeGYvZTE2MUdKY3M2bGpPZlpNOHNaaEJWaHpHcVNDcldDQit3TjRDV2Fm?=
 =?utf-8?B?ek4yZytFTTNkOXBnZkk4QkszVnQ4WlNudE9lTU40RG9EM1ZwY2JPbXJiRlYv?=
 =?utf-8?B?TVdidFdEMU8rTW1pQ3RKSUNzZEQwRHcyVDBwSTVVWkdNcDhCRGRZUWZXQVZC?=
 =?utf-8?B?K0dMMHU2VGZ4ZW1SS2ZoZUhuZkFoaUVMZHd0SDVXZHRjTUIvYWx4dWNzdHB2?=
 =?utf-8?B?bkVUSlViV1FyVHUxRDB1UVA3N2lyeFEzRUgyYVExSFQ0MENHYVZNb3p6RzU4?=
 =?utf-8?B?VFBhcXpNOU1weEVWVjhLZ2NhZE5FZ1ZaVjFJV1p6VGRvYkh3cjJ4UjR4Wk5s?=
 =?utf-8?B?enNqMURFMmIySm92M3ZxWVVLejEzWmozamplb09yZ2tmY1VwQTVjUld2b2JM?=
 =?utf-8?B?TzRUelVQdUJkQ3M2WWJIZFdJWGpwL1oxekJHWVBXVHRUakFQVlpCNmxNNGRR?=
 =?utf-8?B?MGVGR2hZc0srd3BvOVVtQlJiTnMyZUJDdmxFaGRUM0NpVE83V3BCOFRPcU1R?=
 =?utf-8?B?L3BoQVpKeDJteW9HMWlGQnhuYmhHTGxrN2tvRFpwK09DR2dGNU81N09Xc3Fr?=
 =?utf-8?B?ZEliWlgwNUprMjlZa2ZwaXEzcnp2TFNpR1NQT05uaWdqREhXK3dyT0daMmI5?=
 =?utf-8?B?MStONzFYY1hoYWNiY2xYejZMRUdYdm5xckVLSW0wQSs0emh2VDdHZDNSeGds?=
 =?utf-8?B?Y0pmQy9XVTlkd2VzdTk4azl0M0pDWHhZUmVkekI3eU8zY1BsemMwbGRiUml0?=
 =?utf-8?B?UHpPYmZwWU9hR3h3b1pZaWlyYjZjdFpITXJvV01jY3pOTEN5aHQvMkJESUN1?=
 =?utf-8?B?d2hFSTE2ZHVnQzF2Z01adVpPNmxiZ25SKzExc0czWDhmV1dxYzlQZnp0NEdu?=
 =?utf-8?B?aWtiRTFCUHp3bkpTRitJZlJrMEtndVJWYnlkZi9qeVYyM1VxQ0I1RjJKV1Nm?=
 =?utf-8?B?Y0tFV2laMHdlbUZvNUM2MGJiMUNnUERwdXJka05XZERqN3pYN0MyTEFKMFFq?=
 =?utf-8?B?NFptVmhsWXJTUW1WK3Bycnl2ZG94L1lDdE1XOTBmREhMQUtPTzlnZ0NYaVBu?=
 =?utf-8?B?MjBnbTZwbFoxU09uNEJXNjgzdkNzTEd1OEpVcUQvZmI0ZS91a3FXTzRRamFv?=
 =?utf-8?B?V3pROVNpRjhkemU2bnVxNWhHVDhrMFIwN3hnVUxJZUo5bWVnWUFWU3RkYWt3?=
 =?utf-8?B?b2V5bEsxaUdsY05nWkR0RFZObTY2Y3VhdmRPc0UyV25JM3NFdll2WisramRq?=
 =?utf-8?B?TlpUQWUvaEdNTi82K0E2Q2pNSCtDMEtPWWVaSHRWekVWNklhNkFNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60eb6988-b594-4c76-2463-08de6fe0cce2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 18:00:43.6878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJ3odRNqbrv2lu755kAZBeWIjjJXFjvOWtjiFHl2G4KntKtRn3QDhCWBrQJ2AGyJm/TMyFtdm5nzltx+yd+cew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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

ping...

On 2026-02-10 16:47, David (Ming Qiang) Wu wrote:
> add user queue support for VCN 4.0.5
>
> David (Ming Qiang) Wu (10):
>    amdgpu: add global aggregated doorbell bo
>    drm/amdgpu: add AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL
>    drm/amdgpu/userq: add doorbell size for VCN and VPE
>    drm/amdgpu: use amdgpu_user_queue instead of amdgpu_umsch_mm
>    amdgpu/umsch: Add VCN IP init to umsch driver
>    drm/amdgpu/userq: change mes_userq_create_wptr_mapping() to be common
>    drm/amdgpu/userq: rework on amdgpu_userq_create_wptr_mapping
>    drm/amdgpu/umsch: user queue support for vcn
>    drm/amdgpu: add AMDGPU_INFO_DOORBELL
>    drm/amdgpu/umsch: userq suspend and resume context
>
> Saleemkhan Jamadar (4):
>    amdgpu/umsch: Update UMSCH interface and mqd structure
>    drm/amdgpu/vcn: changes when kernel queue is disabled
>    drm/amdgpu/vcn: handle interrupt received from fw
>    drm/amdgpu/vcn: handle the suspend context interrupt
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   2 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  16 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  10 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  18 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  | 300 +++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h  |  43 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  69 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   4 +
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  90 +-----
>   drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c    |  75 ++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 122 +++++--
>   .../amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h |  10 +
>   .../drm/amd/include/umsch_mm_4_0_api_def.h    |  12 +-
>   include/uapi/drm/amdgpu_drm.h                 |  14 +
>   18 files changed, 646 insertions(+), 151 deletions(-)
>
