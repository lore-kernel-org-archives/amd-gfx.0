Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C975DCD1284
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 10:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B874D10EC13;
	Thu, 11 Apr 2024 10:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N/drxm80";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E9910F6F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 10:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfcSYvVbOYlL5kRgZpiL1GwB1r5XozemUtMhyjCsExTJF9YIOmzrufJMhWnaIAfwZGU5VzGhLIF/06DvVCJdRedoeHBO7CdK5dHqLb8y14TZEmIfofoDnLXYsqzCtF3hnibPvaqcbH001cKj3JEmg42E9OFqXy12Z+Dx6F1cc8wF6EFh7Vuq4YdV5DcLH1c//Gr/LVOKgA7oSK34o1bhune8aq5CfTdPBvJ/gZbbWAarkwzbHxCxZBhlhPoUOEt75+LsFpkLcQLlkRc8n/UtG7QtKfGaq4FHv6xYmqyqiC4wKIZZ0CUi7tzFt+m961k8BvmOzwct2MNRpYXOEECAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G9EPsjc8qKWEp/eIDQIRRrK6AtSJqWfikUfXrV8Pjk=;
 b=hkX6miUHVFui6e5bIAUt+7J8hGIwupoVc7e71IOfnmGV3scVlHAd5hrnjLwWo6KcX80WvsxpX2Rm1zS/cvL6cpQIIIBYyXNBDHGc8wFfPlZ1a+Rl+1KXHBstBY4VbES35bvVkIjBuxCDZ/wajV5jGkAkPAM03s46OjW/E6G6+XUUFTaV45H8UGGEfXljMUGiGmx0olnHfvyR4D++hSHcky8oAi3TVKv9QoN4KDuzj1S3aGW99o8ablRY3EaaYQpd0o+UNmZuVrW7QK+ahTDv7RJAEUTqkRzuAbWwKsEE0r/NcOnG4z+3KO92ChfUjQjOsv8yZK7f2BpNK28eTm6wiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G9EPsjc8qKWEp/eIDQIRRrK6AtSJqWfikUfXrV8Pjk=;
 b=N/drxm801nsa3bV7p3ZMGeKzgsPRgoo05m3qKeFiDO4v0pCwyDZ8aslwLIJ9/R8v9N2Dw6Cy7aF7i4A6O/m3VX5XYS58zUkrDgoUenXixbJ7OEBDsVG5WvDkQSfTzptaAJe1isVwZ95AlO/YNjVQMmUsrRl2+z2FwuArNCQI9js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 10:25:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 10:25:24 +0000
Message-ID: <81623e99-58d0-4ab8-9e8e-6b75351a6729@amd.com>
Date: Thu, 11 Apr 2024 12:25:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate the parameters of
 amdgpu_vm_bo_clear_mappings
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Vlad Stolyarov <hexed@google.com>
References: <20240411032844.41839-1-xinhui.pan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240411032844.41839-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 994e406e-6b9b-4b0a-d4a2-08dc5a11b2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nN2vM5azhN1bxIIsH+zcqTq4szuJpC4kV94pmVSvRgq+nDZXxzZglfzqvmcbUG/d5N9JnSsCmYwp1+14WY9iVeawpLtohGEhLmhR0Bf/5lkdcUFTCKPmMQhJKFlMa2sZDSUJ8b9JP9VyFv/5nIWH4TiULbDKeLbgm1zx+09GsI2+NFs/igcW9zJ4+LTtt9IxpKDGxJjjLOPeuNZGsTWby/rFAKehUz/g5UMvq/MNxZ+YkZwK4GMBYjIq3dIoTK2wvkdGo8VsqOi93jNOZTHkN1ZJUwSPswVSx3E/q8ig3Yk8jf3cjiOw9wW0istrRed3kPNx7xUER7e11Y/D1/sjobK5X3L7pSWiB4g0xe7pA7AxBtIyJuixyXYlVIT2rCkqaKJzB4n7OBJspazIM6ZRwdtrVzEp0GwWyspg/uXGBUuLjj614guk2irl2sLuDHR8WROM2yD83ZcKRw8ankaTiGhaL/kMqgqvhqWWJOlRC05t8+8zEMXMX096N3GS+8hW+sG+EuMToLBEHHx86FUWiHE3Pj92hv3i0KJT70CRc2IFxv8ztXqUC/5NIyrx8QZznS5nrQGn1AJ8D6JpgYWxsUuUQp56HZCc/FA8l+AoSwWB+9toC0Fy1I3e4tWDN2Bv7icGhAWE7sj6Q1zUvzQUtEMz3koSt+qtmdPp3CfOx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWVYT3dzZzZvQldwMWxwZERkNGJrTUFwUmNKY1JHSHplbHZObTNpalF6OEt2?=
 =?utf-8?B?UzNDYndiQzZoVlpXUkdBeXRId0NHV01ScU9CUlpjZWZJU2lka3B5dWJUVHN5?=
 =?utf-8?B?bzBtMXM2T3FFQ2dMT2Z3TTh2S3lFNEZtb2tPL3VGRzhBTmdSWFd6RnQzSDk3?=
 =?utf-8?B?QXUxTTFQMDArTnpEb1JsNTlaMjFhd2U2SFN3a2J3NUxFR1FBVjROL2UwQ3Yx?=
 =?utf-8?B?STZnRmpCbldiRHl6WW5hTG9iRDlBNSt1MTh3djNNeWZyc2VPUE9UeHp4d3JZ?=
 =?utf-8?B?T2I3RFhha0xGcFJtN0ZFZ0FFVmxXaUVJa3BQQVk5dFJ6WUEwQ05wSXdVbUtm?=
 =?utf-8?B?aTdEbVBqZWxwRDlJWEphSDFiVkQ5ZE1FQlNkdGdRN2Q1ME1rWFN3Z2FsQTFD?=
 =?utf-8?B?dFpIck5Yc0s4TVRJdnM0bS9RMjZVNjJkUGRXRUExSkk0L09ycHVobUNZOE1Y?=
 =?utf-8?B?OWxRRG1rKytETURRUWowNlpxTms1RlJodnRqUkZyY2RBYlN0aHRVeEJTMDlx?=
 =?utf-8?B?MFNsNTNhaHBESmlTZXc0dWJlYWJmaDltdXJ6aFBYNUR1SHJtSzJBUTIvNERz?=
 =?utf-8?B?VFNTNk81OXNyNVdSR3djUGRYTGROc1MzTzNMSW9lMG1sYU9jZ0tVaTZYSW5U?=
 =?utf-8?B?Yy9RaFJqVlBRZTU1NlhqV2xPckxMYmgrM1F2Wnp2V1dCendNNE1BNUtYY3ZP?=
 =?utf-8?B?TTBOdU1mL1huWlBtVnFvWlVNMzFLVzFNa0lwTW0yRHJtajk4enpqU0FVUVR4?=
 =?utf-8?B?a3NrNm5zaWxSSnBwYUw2Tk1ZdHoreDNoZStzWVFSTUtVcU1RZTlIbURUeFds?=
 =?utf-8?B?TTZWQW5aeWk1d2ZqUU5JdXo1bVNaSU93VnhGR2pnV01TZEV4ZTduK0hYdEtM?=
 =?utf-8?B?ZkNYbS80ejVhRFg1WFYyL0lxK2hVWVpPbkFsdS9NZnpYUEIzRVI3eWd1SVY1?=
 =?utf-8?B?MWZOd1JCd1lQMEdCek5kaXRKeGN4WElBRytRVXdweVhVbHNzWmxUbHJ3dlcy?=
 =?utf-8?B?aTZYNUNSak9tNGUvMnMzb0RSWGtmdHJ5VGRkclFBMEYvZmJ0eU1JUjhvMDQ0?=
 =?utf-8?B?aytFSEdtaVRjNUJEaFZITDBuU0dOYUtRU2JZbDdycVp0UTJNY3phKzQ0UXBS?=
 =?utf-8?B?ajByeXhtWmpRNzRLUE9UVDVvL3pUNlJPTE5XbVpTODF4Qi84WFJuSFZmSnNk?=
 =?utf-8?B?QS91MXpodUxhSDZObkRWeURhNzh2QkNWdnpRK0dOUEtZNlhjUjdTM3Z1TlpB?=
 =?utf-8?B?RDBQMW1wNStNcGI2RjBtUjd3eWZ2blJSSnIwWXA2aFZxLzRXTzUyelFtUGth?=
 =?utf-8?B?cVFmNmZiaWpndHAzSlN1NXQyYnE3azlOcnFFRkw3RThxMlEySG9CNzNibjQv?=
 =?utf-8?B?MTRsYkdiZ0VWM2NYTmpLS3YrdURrWTNvRThHei82bUc2c01YbzY5U1BsY0lV?=
 =?utf-8?B?MDhwU3RwT3ZUbEIwSWpNRE03enlsZkNmcmZ5U25TandMRzFYVXNQcmZENVZZ?=
 =?utf-8?B?S0lCWUgwOTVPbHdLR0dMZldQRlRiQ3JsQXdQSzdzdDJzaUN1NHFTKzBSNkcr?=
 =?utf-8?B?c3NMUGVPZFJtam45eHNxRktMb2hVRGhOWnFMUG82OXgraXkzZWtJWmJpSm5w?=
 =?utf-8?B?Y29udGJTaEU0eWpubGRFbnh5ZVFTdlJPL21Gd1JEK29KcjZScUVhRTMyRVVY?=
 =?utf-8?B?dEd5RmVMckxXc1gxbUQzM1R5MmlPUGZIam54SmNTSnNPa3pJYnVFelgra3Y3?=
 =?utf-8?B?WWNNalh4aGJvQ3J0TjV0OG44K0VjbVc5TitCNDZ2cHZvWEs1bmlPNlVOVDN5?=
 =?utf-8?B?NjBHL3BvNlRCT00rcENBb1EzaVA4MzBBVlFrVWQrQjFKT3pneDBYOS9zc1Zk?=
 =?utf-8?B?SzV0eHlkeCtvbk50SjVYVkREWGJQY3Y0aEtZc0Q5Ykt3UGNCd2NoK2ZUVEcy?=
 =?utf-8?B?cSt2dkdUdm5UL3BWZWFRUjUzMUhJenZUQzkrd3pJSEhJVExqSWo0cVUxZ2dz?=
 =?utf-8?B?U0NTTGJTOEY0cWNLWkZlYXVZRFZYQmZPODJBNzJRUkJYVTBrSTVQZkNSYitu?=
 =?utf-8?B?dDErK2pvMXdNQTJ4YVVYakxHZjJweEgzUFNWT2ZIYXZjY25WYlkxem5ORjRy?=
 =?utf-8?Q?3r3CNNaAiCdT8pcDWj9n6CIw5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994e406e-6b9b-4b0a-d4a2-08dc5a11b2f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 10:25:24.5472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wkYYo8jCMhleref3D/Pu5nPcDfbDvN4NXzcQSdWswHOLbs8vjq86yt8a1OfKbAX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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

Am 11.04.24 um 05:28 schrieb xinhui pan:
> Ensure there is no address overlapping.
>
> Reported-by: Vlad Stolyarov <hexed@google.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 8af3f0fd3073..f1315a854192 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1852,6 +1852,12 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>   	LIST_HEAD(removed);
>   	uint64_t eaddr;
>   
> +	/* validate the parameters */
> +	if (saddr & ~PAGE_MASK || size & ~PAGE_MASK)
> +		return -EINVAL;

Well as general rule: *never* use PAGE_MASK and other PAGE_* macros 
here. This is GPUVM and not related to the CPUVM space.

> +	if (saddr + size <= saddr)
> +		return -EINVAL;
> +

Mhm, so basically size is not checked for a wraparound?

>   	eaddr = saddr + size - 1;
>   	saddr /= AMDGPU_GPU_PAGE_SIZE;
>   	eaddr /= AMDGPU_GPU_PAGE_SIZE;

If that's the case then I would rather check for saddr < eaddr here.

But that actually shouldn't matter since this code here:

         /* Now gather all removed mappings */
         tmp = amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
         while (tmp) {

Then shouldn't return anything, so the operation is basically a NO-OP then.

Regards,
Christian.
