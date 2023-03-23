Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9D2C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 13:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E9010EA9F;
	Thu, 23 Mar 2023 13:54:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE7B10EA9F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 13:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+yDb6DHjCuTKfD+mLjEilIEB1QBxNe7lav3oTZDSc7DN27zc78SLhL65gRYnQeN0bQabaZnlh117jVKbrol1//yXsZvAN9aMFvYSGM58/d6aCg82nqyFpe7rQZmEn7Slicld+71dEgERavxmIiubJFoWnklDPOujVs5hxSFieHJzfO4VpDWgKJULAE5XoKuY/ItFunUgTuX7YcxbjQwP+tRgELnEjucF5JoIMVHYUGMY4umbVGPXZcK0wNxaddEGWDDs9lCN72XVUacUxlRS0hkJno5kqI8mjuivrF+fDPLIIPYB3ZnHG2fxY8hPqtCpCXuZIruBzMG05tv4llyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtkyHmf6UnTidnYBa47TDm5PkH0ZrnfFP8LgDtiFXp0=;
 b=iGNzJ/YxMdsjKiI5HDlazqiNXt7XJtjFlwYPfIzdH6bMc33ymOLYOSKKPAuErEBPwFxv2enRjt2P0Xvcrq+5pEa7Ydubx9UHzxJqKEHwVt07iOSqoExh53npGClbQ1/ZSmogAG7c9ykVFzcLb9Kkw/Z8FZD3gA267NNwmDdPcYmUmDb5EzahYjP+Yg+cm7psG2lxHHzNEeMu+VE8+kfxys+lP31le/MNyRXBBmcmL1t12XaYgGlA/EebrJEDMY4R5LgZqakUGPP4Ox8cTSkYXWk26Bz8YMAoTMOkB/gkWWQtl4XV4lBlvocfimCe7rFvSJ2ab817DbIMnz439vOANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtkyHmf6UnTidnYBa47TDm5PkH0ZrnfFP8LgDtiFXp0=;
 b=qrnYuRFDCVQzLwNmSDIEhjp1Pd3cvVpeNJLMRzvGBilndGgMGBOsGSklIuEiYHdNnuC4htnmAl1JNxQ4+ALP9wcqBYEWzlkl98etsSi8NaDQ/02p7SZSGP9RCHphFJdt6y/hhvCo+W1IDIH3EdtxuXjutlURjOC1hPGqKsT1vWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Thu, 23 Mar 2023 13:54:25 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::e43d:5bd2:7a85:d0cf]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::e43d:5bd2:7a85:d0cf%7]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 13:54:25 +0000
Message-ID: <b308338a-663f-8a5d-7784-39bed8af1f5c@amd.com>
Date: Thu, 23 Mar 2023 09:54:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20230323120426.3960144-1-srinivasan.shanmugam@amd.com>
 <98edaa70-bba0-77c9-1ece-64700a3562b6@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
In-Reply-To: <98edaa70-bba0-77c9-1ece-64700a3562b6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::18) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d2d8ad-908c-472e-f1ea-08db2ba61ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUuIp8i/YQ3hVvvveGVs+MQkITAELskW8L4nfhoQ9fn3iBdCLSPKa3XgW2cf/b/+mIui45LGnkH0eIKE/BD9Z805UNHVSAf7Umb5br2/wA1ydLDf9hfgZ13qe6/Xr6r3KbPdY4AbKq+4WzdCNphIVlW5q3P4eZIYzKyKLqhuYlSo0cshVeqKufiFfKVlYAdzS8Dxy59H6LihfnqsqPTHT0nxOhXaSCekOesZOYxlN3KpAm5lInjTryVon/CBS0iqWac/F/pBdtkRS+IhBWnc6rzUl/gNEDOEddHcEmuSH+47VlnApSXXKwYUnp0UKAz72IVFDtqkZX+LqgT++bkHFOwzvzEqYw9hxDVsHZyHusZThL+DaoMSTZ/wCp1nSlBUpd+23IMuLPCCOy2d1ITV+fa4MlErktaqL3UJwOM4PchpFjC8dhlZgoEO1vrcboktYZD1noay0RI2b964aUhlovxUrl9EEnY9NCVXK5Y7X3jdkv23mNaeo1eIe60jeAYLU0rkTmJIhXAh7etRVxmlbRFXmiGLiarsoN+KFD5NcsAsE5IjQspkueonoA8uxKhvXKiQ70ItoDccYtThmOJu00rUzFJsI1XvrIRzlFilzOol/jg+oKlaHeJj/3a0PKcgUvDODb96SXfhlknMwdCc92FZ2qA79a4pUHl/ifXVcoaYqz3GChDploB1dMp2Xm7/vz+8tQ8knna5YSVdreURZwWacMb3z3QzmG4o7fZ+vFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(31686004)(41300700001)(4744005)(66476007)(5660300002)(4326008)(66556008)(8676002)(2906002)(44832011)(86362001)(31696002)(36756003)(38100700002)(26005)(6666004)(6486002)(110136005)(478600001)(316002)(8936002)(66946007)(83380400001)(6512007)(6506007)(6636002)(2616005)(53546011)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1JJR1Bhbk1pVlMrbjhsV0dzS3ZhOWpxNVNGRExpSEFwT0l5RmczczlCVVln?=
 =?utf-8?B?WDN2dFdkUjI3UE9hUFB0YXQvRVBja3VQNjlHc1ZZaExaVnJyWUhBZUNtV0dR?=
 =?utf-8?B?eTY2bUw0R2ZkYmhVMjhTVjZ4M1QrNGtsdmtIdjdmNFAvVWJNNmlSWndMUmd1?=
 =?utf-8?B?cmhlM1NQZndFSGxsbEtpK09yZWpaRFZWMWthUThIY2YwK3BYK1BPWW1jQ3d3?=
 =?utf-8?B?NGgrekM5bjVqZjZXd25BTHY4UXpoak5LRlNMTmhDZ2RzV0drR2VIL3JCMjVQ?=
 =?utf-8?B?bWhJOFRsTzRSbGx1alhzNXRyYmNLdWtFZzJPcm4yNktnWUhUQllqK2dhRFBl?=
 =?utf-8?B?NGJEOWRVallvZ0tNaUJqR2RSY0pkSjFDcU90REJwZUR2UThkUDlpUEJlblBV?=
 =?utf-8?B?YlJaN0dFQ014a2t5R1hONld3WDlzWWZjWWZMRnhiNkVtUUZzaHZzMlQwL21M?=
 =?utf-8?B?emIrRDNmNDQzNUdtdHRCVkp2ZG40dTJCWS9MUFdFbVhlLzIwZmI4R1diaWdS?=
 =?utf-8?B?WlJnbWZzTnVmZElDbHd3aWZVRUt1dlFHOWpFY1VGRithRFk2UnRWanVSbzgz?=
 =?utf-8?B?S3dJa3pSVk1jL05zZHVkSTZldXlRTS9xZyttalZnaTQ5dnFqeVhCUzF2L29p?=
 =?utf-8?B?ZUdPTHkyWDFHYmNka0twUEpIL0ExN0ZhTVd6aFBmVFVMN2lWSmw3dVhENlRp?=
 =?utf-8?B?b3hYeUorWTdnN0lGdi85N1NwS0tvN2lhZEFMSk5VSTRoNnFyK00zbXhjaEV5?=
 =?utf-8?B?d1lBT0dUMWJONzJNNjZReTFXZnFYZWp2SllzZThJLzVocnM3TlFtd1NPdjlo?=
 =?utf-8?B?U0F4Q1dJUTFkN09YaHcrSDlKK01pV0VQQ3k4dnVSb2xWVi9Za293ZW1LckZP?=
 =?utf-8?B?V2tyQzlxVzhSRTBhMktDcU45TnNZSHRnMWJvbkRiMHdpNTJnSWRBWkF4aFNV?=
 =?utf-8?B?em1aUUhaaUNHN0ZIYmFXbnRYSEE3MXNaRVBWU2s3ZzMwRTNZemRjeGxoRHlY?=
 =?utf-8?B?NmdUbzVyNDQyVEZ4U3g2aXFrMTltL09zNU90dDJWbHJSSFdlT3FxZDJRY3dm?=
 =?utf-8?B?UzNoVTc3aUI2VC9qMnpuZURnUWFFdENRcWk3VnBsdnVRK0E5NW82bHlzTEo3?=
 =?utf-8?B?TDE4TzNoV3VSK21MTkFRQWQyMkM0WktSOVdTV0tmaEJQdW40b1BZdllYbWg2?=
 =?utf-8?B?MG05SkFjMVlTUlM0bS9YMHBrSWJJQnE1czhUL084blNPMkF0SWtNQncyWStJ?=
 =?utf-8?B?MUFzb1lEUngrMForbzNzKzU1bG8vaW9rQjZ5cDhuR3RISGdza0hIT3cvdE1H?=
 =?utf-8?B?RkdGbFdOd1pVR2N4ZFRBMEcwS0Nsd0hpYW1DVmlPVGd3elpDTzRTSW84MDhr?=
 =?utf-8?B?T2lld3c4dGdQdXJkTzk4NmE1ZE5WRnlSbU1MYjFjUE9yZ1JzTkhCa2JpNnBI?=
 =?utf-8?B?YzBxVHM3Z1QyKzlkdU45Vm1kazdTemR0QlhGTHNwc252SWdCTlhwN3h4WUp6?=
 =?utf-8?B?Y3RGdXFjVk5adExYWGIvNGJKSmN2b2NwVDUwNnV6blROa1dyY3h5R1pnU1F2?=
 =?utf-8?B?V2NrcGZ5QitrZFpzN28xVkk3LzVkSWRkWW9NaEdVUFJNUzZNMHc4SDdDN1Jl?=
 =?utf-8?B?UVR3UjRUZlRnUWc2WjBUK0hVY0w5TXFQM3JxTnNyRnBuZVdOWjA5ZGpaclhv?=
 =?utf-8?B?YlEzeWZHR3B4bmxCQU5TdnowaWFLQ2JZcHBBdHY3TUZqbFl4TGlhVDA3aEVq?=
 =?utf-8?B?YzVLQmdGS0h2c2xtdVNaelFGNENVdVFmdjl4VXVDamlWTGhVWkFjeUNXeDJR?=
 =?utf-8?B?REFnU0RVd2diTldEQ3NBYmVyRWN0U2xDUkJDTDhWamQwQmJGOUlSS0RhOVph?=
 =?utf-8?B?Skk2QjM3TTVVckZ3dkw2ZlpJRUtyNFc4VFllVngySjBjcEJIN0hhby9GU0t4?=
 =?utf-8?B?c2x0aHhIRm0vMURyNDUvVW4zMlRRcHNvbGNmeWZ6bmdqc3d5TmhYTUxvRXlX?=
 =?utf-8?B?MGFZYlRKbHQrYzBJMDlUeUVIZW9lcFJnejhVNm5XbnljYVZSelU4cjdiU21q?=
 =?utf-8?B?WktvQjNOZW1hWk1MZ2pxM0lLanhjQm10UHFQMGVsV0NFcnJXM1duZ0YyN1Ft?=
 =?utf-8?Q?wLAq+0DOkOuaZVPMMiqy49I7N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d2d8ad-908c-472e-f1ea-08db2ba61ca4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 13:54:25.0694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nK4ZCfdXXFqnp6p/njOV2h1XgidhPZwEdCuLZcY+UZWj9ZUkgJVpSpCNRGUUcTyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-23 09:29, Christian König wrote:
> Am 23.03.23 um 13:04 schrieb Srinivasan Shanmugam:
>> CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ras.o
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2567:28: error: bitwise or with non-zero value always evaluates to true [-Werror,-Wtautological-bitwise-compare]
>>                if (adev->ras_hw_enabled | AMDGPU_RAS_BLOCK__DF)
>>                    ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
>>
>> Presumably the author intended to test if AMDGPU_RAS_BLOCK__DF
>> bit was set if ras is enabled, so that's what I'm changing the
>> code to. Hopefully to do the right thing.
> 
> That looks like a nice catch to me, but I don't really know the ras code 
> that well.
> 
> Hawking, Luben or whoever is more familiar with that should probably 
> comment as well.

Thanks Christian--yeah, it looks like a typo. Fix is already committed
into amd-staging-drm-next.
-- 
Regards,
Luben

