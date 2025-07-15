Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5137DC83F22
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 12:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA35B10E5A4;
	Tue, 15 Jul 2025 12:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yhQnfOzU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D456510E5A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 12:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCBv1YC3oKLjS+b9kDbZuAzx95vpTupeTfezzMsShUwZ/L8Xr4lR+Lui/ajo6hZnBfigiK5avc4e8oTAO4oTiPkyEmZHiQE76Vj26OYYB9csILpDSJMkZDrDeMyA+Yxpw6ffnVmHVgfbfjqsdgJlamhyFodOO7T1ssdnqq6MKH0C0XEHcaLVSERCkeoqqMxchfGKBwA1uC7XFcp05N1wKfF3rWggvYa3acTumh8GUYtnL7embBBVx0E57B0fzBnyoxN2/UFrr5tl2/mX5dmg/Z+Gzp0e17NmAjMrY9zUXAjR6+V8jXOhx+XYctepqMMdkjpX85PCCC6QOworjb3yzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fezLoE0VM2Jn7gF3ycN0dJ08S6WPXarAtx7ovsr7JYI=;
 b=cxkaiOLg6hwK1DjapTUU0/fZSObjmTrXeC739iJ4LIOUm2QCvhRTEwo/8j13WiJnxio5bNMo84E5SDadiRxZkYMRTrJ7qkmit3VjY/X9813PJaxrtcJxP02UxRZyt1Wn4Xx2pGEIcKx6galDhbpO6+8IL+1XX2hfHp3t9cK2dO3ie/jXX5/2bDG4N0S+0brGyJJDJVoG9dPHodLPYyWLgDYayNGzrK/yQR+Fm7zIzFUdiOQY9GEb0TIAadqC2iRxlz2kKM0JS5W+lgQU1DrzUjUexeONPUgDnxuH1hPt8v+OG7ldhXHpbbjBYxacU6IZsS9Hp+AHe9Q1wHy7b5DstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fezLoE0VM2Jn7gF3ycN0dJ08S6WPXarAtx7ovsr7JYI=;
 b=yhQnfOzUQ8hbTABUejwynPiWEB9NbeaRr5vRjCvBe9C/MPxvtfhAH2VsXax9Bm0RTVbLGjSPplq1d/Iv+n8/2TOVn3kEY+oSQhzPvWvO2HT3PVgcppMNotNi0q7zT8GwlNh6BWmFWcgvobDHHqXk7p5GaP9bCgthlgukV+Cfa7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 15 Jul
 2025 12:17:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 12:17:56 +0000
Message-ID: <42756550-1e01-45e6-9103-46ee6c689811@amd.com>
Date: Tue, 15 Jul 2025 14:17:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] drm/amdgpu: track the userq bo va for its obj
 management
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-6-Prike.Liang@amd.com>
 <f391283e-8e3c-4d07-9da4-8bfac73342b5@amd.com>
 <DS7PR12MB6005F4C0545356AE60FB5606FB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005F4C0545356AE60FB5606FB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 96896311-b3fc-4d70-ca09-08ddc399a145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1RGYmVzM3Q0MFF1VGdyWXN4L25pdHNpSVRkQWh1NGxYOWhLc0ttOXRuL052?=
 =?utf-8?B?U0lVV3ZLTG9lWXBDOFpHa1ZZeloxSXRtY2sySGVEMjRpalNiRlkrOVRVOHdw?=
 =?utf-8?B?d3krWVJPRjhnMU5pdlVBSzhhS04zdVRPQ1krRG1GQUM0bDZLbUwxdGlEUGlx?=
 =?utf-8?B?NDRmRlE1ZzB4ZHR1TDRNYUJFUnNxcTQzNGFJWGRKcFJVZTlVaDVsZUJNZ1Jt?=
 =?utf-8?B?dkRmamozdEFaMkhZZG1uTjJLSnpJVllVVFdNUCtqNSsxMmxBYy9CTHRFbm5x?=
 =?utf-8?B?QWMwQ2QxdlZydWs0dHV4dE1vYWx2aG90elBOQ2crVUJLK0pseStIeTRVcGMz?=
 =?utf-8?B?TVF1TndyWVN0OU5mZDFvaFBNK3hmMUVQekgrY2FiSXNBZlZaRFF5ZWNieVNY?=
 =?utf-8?B?N2dYMzVqQUtJVXNBb0FzOWRwMjdyZlRBd0QxK2ZaQ094ZkxaRmE3b3lsSTFI?=
 =?utf-8?B?U08yTEdlVm96MWYyYzJxbXBQU3RPSDZib1M5a0tTNU1wZGVxZnhxSnZoVmpC?=
 =?utf-8?B?clpyVGxEbGFpTWRJbGtSKytEV09LRldpSUVzdk52bWVmdTZYaTRLNW1YSUha?=
 =?utf-8?B?a0U2dmFFTFpEVVdHTnF3eDF1Qjhia05MY3ZlblFHSlZOMVUzc1JjbTNxTnFN?=
 =?utf-8?B?TGp5YVVoZUR4eWc0aWU0ak83OUlOMHIyK0tQUmtoUEFMUWNwTVpoT1o1L1JY?=
 =?utf-8?B?TDM2NkFxVWxFUnFGUUppQXJCN3hQbjZlWGFJOStXUjJlU1pHTDRRWEllMUY2?=
 =?utf-8?B?VjBXNlptZGVLc04yZEkrTUt6NUsvVndDWXlCVGVGc003WGZGUExkYStqYXF2?=
 =?utf-8?B?aWdZN05WZ0psUVFSZy85dnRuazYxU3hOZlFYRUNqMXp1bU56aFdCd3RrUUlO?=
 =?utf-8?B?TytZeHFPOFRBazZQVTcybGRZV0drckRFeHc0NmVPU1hDZ0E4SGMyaFpEcDBH?=
 =?utf-8?B?ZzVTdzB3eVVIdDhKTzJqaW1MRkZWMk1TUzZlQVlTaXN2SDVhTXk2b1ZHVytO?=
 =?utf-8?B?aURyY3RCcnlzbzkvVHkrczlsMG45RGNwSDl3QWxZa09MMGlaY1N3dkFiQ3FO?=
 =?utf-8?B?L0lOR1ZxTTR2Q2dtSGZiSHdVZE9VcndROCtSREZhWUl0RFBLNC9PdTcwS01K?=
 =?utf-8?B?d0lIMEVSdjBvNi8rS0paaXhlaFZvRzFnQkh2dzRiZUZ3a0lTQjZYblpjbGdT?=
 =?utf-8?B?bFNFTmhTQ3krSXk3ZnJwWUF3WFF6c2Y5RWNCM0xuSW1MZTE0Ym1xMWthK3kx?=
 =?utf-8?B?OG9xYTdpSHJXQy9BRytBU05yV0NuVkdEUWF5UG54ZzdBZ0p6YTN2Q3VIdWc5?=
 =?utf-8?B?VjlpUHdabEcva213cU1HN0NVS3BMVUYxTlU4NitZczJrQUdtYlQxa1FBaDhM?=
 =?utf-8?B?Y0dXUGFYWDZWQWNodndXR3ZGUFgwd3NnUTZmbDI4c3FHcU16TktzaEtCanFZ?=
 =?utf-8?B?QzYrRUk3ajNuTVQzSjBiNUxFa3Q2SytsOG43cHlmYVJvR2Z3cmRqbndBOVVG?=
 =?utf-8?B?bWh5SWI5VTVxQ1ZJWXdvUktHYVdXNS9Lb3pQTkxwUXBlVDBZT3ZiaW10MWxm?=
 =?utf-8?B?bWcwUUp4b2sxejBWUTdEeHJVd2V3TzZkNU9VSTNmNnh4MDBNMzNuTGNRbkJq?=
 =?utf-8?B?bWlHS1JaRnppbWRsZ01CSWJ2ME9SQllCanpxbDA0TmtvZk9YQUVhVXZZckt2?=
 =?utf-8?B?dmlLRmZPeFgzL3M3S1NUcVNxWURiVXdRMXFjd09IWGNpcjdiQUlKaFc1UTQx?=
 =?utf-8?B?VVUrSFZGS0xMRENqaGIzK0czQTRVRVdzTmdxK0Y2VzdGRjZiOWxTbStsRnVr?=
 =?utf-8?B?NWxxRkIvYmdVS1ZEenBsMXo0NmZoeHEvY2c1RjFDdEovQTB3Vml1Uk5LMXR2?=
 =?utf-8?B?a3ppR2xabmFRSmJnUUd4Q1cxa1V3ZlV3S053SEVYTng2NFhNbDFkOXFPanRM?=
 =?utf-8?Q?eBh0VzXvJH0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjBYczBZbks4YTdrSDZxTjEvZWh5Q25uNENZVzJwNWJIaE5vY2pONlpFN2tW?=
 =?utf-8?B?ZFpOaENiT2pwU1ZBaU84V1JDRDRnUkdKU0NxK2hPOVY5V0Y4c0JDL3ZCWng3?=
 =?utf-8?B?UHFtNGh3QUJhUEFtSjQ4TnEvN0lnNENuNnd1eG5vZzdKY0QzUmVsREIzTWY3?=
 =?utf-8?B?N2ZLc1M2bVVFT3hROVlXeUV6b2ZoUU5Ed1pyM042U0daK0tydkYzd3FKdVk1?=
 =?utf-8?B?RDlhNEtJMGNiRGVDcUtONHRDTFlXbWlRaE5tNU9HSTNXdStXK0FOWG1pMkMw?=
 =?utf-8?B?b3Jva2h3alBCNzZ1aFhlVU43QjhHemVrMVdQcE9WWW5mTDNCc1B4SVFHVDBT?=
 =?utf-8?B?bjczNG42ckpLeEh3Q2FvVHpRMjdHZkxncFRXSlgzSjg5eGFXSUxUQXJUckND?=
 =?utf-8?B?Nnhub0hXSHdZWVVTbmczRllEU1pCTHFJZUNyaFoydmRFSkdaVUEzVkM3QVQ4?=
 =?utf-8?B?cURTUStzQnUybGdBNHoxRURxVGFJczBLYnBzNzZ6bE5BOVFMTHdGZzBxL1h3?=
 =?utf-8?B?TkZKMGtQYW51cS9GaHR0a2dPbTFpenI4QldiZ212eGFkUE9VNFFWOTNndzdL?=
 =?utf-8?B?MW1Ud0p4UVRoN0ljUm5CTWs5akk3L2Y1SW05bGpBemJ0amRNZDFqT1Nsb1FP?=
 =?utf-8?B?U21sZWxNSStrdzg4cGJjaDlZVXNhclcwTSs5MVQwVDBzWWNBZnM1NDE5VXJo?=
 =?utf-8?B?UkNOOE5UckV1WmFreTFZOUEwbWdnWmJHazBVMUwxd2dVQm5VWEhET0hCS0dE?=
 =?utf-8?B?UDVhTkFuWmxyaFB1ajFla3RoL0c0YmFHdElLb21Sa1ZkSVB5eDJrb2lYaml0?=
 =?utf-8?B?bEdNNnRKUUpXbXZRV2VjbmRsV1RXL0drc0lhdjFqT2p3byt0OVNwbVh4YXQz?=
 =?utf-8?B?Q2dkS2NZWk1PMUdFKzlqSUVOQ3lZRUpKem5jcTZ1YXc2M1NvcitKWVpCekpp?=
 =?utf-8?B?K1VlUnJzdnh3dU1NdDFHVUFqREdNOVdqb3lhbnBmMVdQTWJrb3J1clpBVEt3?=
 =?utf-8?B?K2xpVCtQL0YxNmxYanllb0pSdTBYckZ0Q201UXF1OVpyeXlvZ25VMzdoZEd1?=
 =?utf-8?B?QTB4WEd1M3VybVU1ZXVsUkQ1Y2tURVlQOUYzZFllTERaeElDNWtZdW1qOENs?=
 =?utf-8?B?SzRKbm1USFdZV3IxdnRZaVVXc0NrQ0tWQ1BSVklNV0tMUE4zWXdmSUNwUDd5?=
 =?utf-8?B?cFErd0J3bG1nbGJDMlh5QVdXQWhTUVlGdjFYN0p6QWJsT3NhNmNoTmVqTWRE?=
 =?utf-8?B?YU5KNXpJVnVKNkQyQTZvdEE4N3NYbGJYeUZRT3BpNk04Mmp3dnMzR2hmK0VJ?=
 =?utf-8?B?aExIMGhNeUtiLzhPb3BQWGt0NlA1YnZwQVpTUkZFUXFqUy9uRUpRMG9xVjc4?=
 =?utf-8?B?Q3dqVUNSUThkWHFzMklxY3I2Qnh5TzIxZkhRbW0rL0lFclZac3BoQlI4ci9l?=
 =?utf-8?B?U29Wc0k0OS8zTmxqWFBudjBMSzRucHh1MTBEM1laL0g1VHpoVFFqalpMS2tp?=
 =?utf-8?B?ekdzTkM4cXhQY0JSd0pUQURFWDlOaUNLVFlYanVQTmxvM0FFOEUySVBVcTc5?=
 =?utf-8?B?RW1VRytBL2VLUDFHTHZsb2RtNjhxY25uV05mTTRRVFZEZzlMWjMxNi9HNlNS?=
 =?utf-8?B?ZFZaUitnSXJ2THZ3YUNjVEVUMmpqc0dHKzQ3RHh0MDZhVHBvNmM4U1dkNkVa?=
 =?utf-8?B?TVJRemx2T1IySEUxOUhOL3UrNHBlUkM1eXpWMWZlUytKZFdqR0pEWGkxWGFm?=
 =?utf-8?B?VzdvZE5GL2VIMGttajh2aW9LdFhKQ0pGampFUnhnaE5JUHF4eUU2cEZuQjFz?=
 =?utf-8?B?TkswdTlybmIvSmV5T0JldjhMMVR4RDNDNlpRcE5LUVRSUVUrcGVXZjYyK2lY?=
 =?utf-8?B?bnFMOUkrQUQzZU92MUlpK2poQ0pCMmsxZDZGTU0yQXQzMnJ6V2xQUWpta1NB?=
 =?utf-8?B?NHV3cG1WOUVHVjhVajRxNGcwK2c5d1hvSjF5TFQ5bnhtcHFDMWNOZ1FEaDZP?=
 =?utf-8?B?SW02clJLYWtzQWdOYnNJbDU0VVZYUGlzcFl6ZzhSaHczN0dvZlA2c0kzMDhL?=
 =?utf-8?B?Z20vaDdNK0E2b080UCtvOUYwR2luYTR5UHpzRkliaG1hQ0o4NXduQW1TMDBZ?=
 =?utf-8?Q?slq1yb2thlG796kyd7AojIyAb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96896311-b3fc-4d70-ca09-08ddc399a145
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:17:56.2029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B54rR55ccOLCmP/IpgzQfF5Xb2+xBrhfvc4ejCfIFYtrvUMAwU5bp5uU+5QeFUwN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940
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

On 15.07.25 14:05, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, July 11, 2025 8:11 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v6 06/11] drm/amdgpu: track the userq bo va for its obj
>> management
>>
>>
>>
>> On 11.07.25 11:39, Prike Liang wrote:
>>> The user queue object destroy requires ensuring its VA keeps mapping
>>> prior to the queue being destroyed.
>>> Otherwise, it seems a bug in the user space or VA freed wrongly, and
>>> the kernel driver should report an invalidated error to the user IOCLT
>>> request.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 2856c2506bee..81fbb00b6d91 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -510,12 +510,24 @@ amdgpu_userq_destroy(struct drm_file *filp, int
>> queue_id)
>>>             return -EINVAL;
>>>     }
>>>     amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
>>> +
>>> +   /*
>>> +    * At this point the userq obj va should be mapped,
>>> +    * otherwise will return error to user.
>>> +    */
>>> +   if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
>>> +           drm_warn(adev_to_drm(uq_mgr->adev), "the userq obj va shouldn't
>> be umapped here\n");
>>> +           r = -EINVAL;
>>> +   }
>>> +
>>
>> That is still not something we can do.
>>
>> Destroying an userque can't fail in any way.
> Yes, the userq destroy will continue performing in this invalid case.
> Can we keep this part for detecting this invalid destroy case?

No, exactly that's the point there is no such thing as an invalid destroy case.

Perfectly valid to destroy the queue no matter what state we are in.

The only invalid operation would be trying to destroy a queue which doesn't exists in the first place.

Regards,
Christian.

> Furthermore, it looks like this error code will not affect the destroy request at
> userspace since the Mesa driver doesn't check the userq destroy return value.
> 
>> Regards,
>> Christian.
>>
>>>     r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>>>     /*TODO: It requires a reset for userq hw unmap error*/
>>>     if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
>>>             drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW
>> mapping userq\n");
>>>             r = -ETIMEDOUT;
>>>     }
>>> +
>>> +   amdgpu_userq_buffer_vas_put(&fpriv->vm, queue);
>>>     amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>>>     mutex_unlock(&uq_mgr->userq_mutex);
>>>
>>> @@ -636,6 +648,9 @@ amdgpu_userq_create(struct drm_file *filp, union
>> drm_amdgpu_userq *args)
>>>             goto unlock;
>>>     }
>>>
>>> +   /* refer to the userq objects vm bo*/
>>> +   amdgpu_userq_buffer_vas_get(queue->vm, queue);
>>> +
>>>     qid = idr_alloc(&uq_mgr->userq_idr, queue, 1,
>> AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>>>     if (qid < 0) {
>>>             drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
> 

