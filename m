Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEF7C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 16:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 169E310E039;
	Tue, 28 Mar 2023 16:30:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360F910E039
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 16:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScrMpltfYBN0XrtuQIRWKzPZJc3y3X2peM2gqtnbTwWeeS6lnyIP4A1Cq0vJcl7fPDbM9ilvfMS1273rWlnrfOvRBLpdgSFDgjECgp7wiwv4iXCFniNqFXxKSZu2fFY6trAy5itQ3/FwqYiOCylgvLFjxSNzFOjOJMlN+EDI4GcUytYSJMexVSxDcQGVwDmLOviRcqnRDH9IgnJG0/Zd4Y6j0991bfKiuvvHgPHax/lBE72Yonj68XG5WehVUPSdivkpFlIcZ/b5nWq3Cv4q0GgrKR+y/lSSKO1GneXSlAw2g7qPkU1hIQ9Wt/FWHCwv/VCeEjkpD0xIpfvgP+c5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL/vLy/cwsAXadcXJPUi6LLtsk0f9SRzTFSkHLMClGg=;
 b=Hg75cpzjM6S3PJtboj6qKLbZyNwDs8HYNgQcswmnXmT/1LRPurC7Au0l4ozcUI8JH/IkPdI0DlKWA7Ll0r4Dwpopf9oMXJqyOJEJptfU31qnU4aQvK4EQZb/bXuAcLZjr6QJJcdlf7hc4D9aJowiohV/UyzZb2oz2FDblgP44mdJLUmhQneW0O4Ep/szGR8m/G04qZO3HCL48jBoLdZV8acVPMfS3lDNyNwjaZplStdST2fly1QhOA+BpG0mb2YsBS28oQBmBGlNcCfJpIv7yXwcDVRHI1gyDEPN2qgIK/YfNbtaPtKVW4RY+R0sqwNerDv2RPuYBPKE/zqsgHJoKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL/vLy/cwsAXadcXJPUi6LLtsk0f9SRzTFSkHLMClGg=;
 b=nRsgJI2y7nlmEPVw4M1PtUO7v+IloSCfpKkaio69yuW/oyopRIFutQ5zj/Hp7MTwiO0IljeMc7iGLpCJcJTaUrIrV1tu/FnWljg9PRXsChliuJ0y1DredUdTVhTadyAfVnVgkEnNh+a0pGC4fQ1eCJeVQjtnGd1eGyL7y1rhDaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 16:30:19 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b877:9974:5a14:cc37]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b877:9974:5a14:cc37%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 16:30:19 +0000
Message-ID: <cf5a5181-4c3c-10ff-1dff-36a34658cea7@amd.com>
Date: Tue, 28 Mar 2023 12:30:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230328001119.1363691-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: simplify amdgpu_ras_eeprom.c
In-Reply-To: <20230328001119.1363691-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::18) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b205f3f-8680-4a3f-c60e-08db2fa9b853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQBmM++674D8Sfe/OJqmhXstTS0S9EWt38hv9h417akJDTIGXw1gxDqmImip+ZXEqP6WhSY5KDVquZhXki1vYkZMWLViBG7QtgyCesJgOp8WykGR6VHG7sAxLrxSDpi32gO+51lmY5j1CtOl4wA0slQD9ahz31kIyVbTFPRZ+pmKu4fy17WUnRku/Ln8hbl4pftOsBTc8/aHQ00zDtNF0JuYatvuSokcvs1oDubFXNELDwwv+fb3V1ClP8DBwzAZQmlL1eadzuyWPfFgwPEivTzmsqCw6ZBdPyLeDVrUyjGdbdcy1ixdJfER2P146BQMpa04GiPCFUnHRfwdq9EBQbWYuigHf+D0/gl4Dde8TNhXTpLCcx9xUjYAzeV5eS80pmArOIlDg/EXnbezvaJfJmHrnfwvzhuRl5GJNuLTypXZ2LwUrw0n/qtRg6CvzmCQ8yP+uZXy4i0DbKD4ni6996P1ntzZ7XiaY9ElDwq2mDWNmF4fzzuRq1pNfGmeiagpmqMcrLCsvbBQhT4h8EEn9C0I9/+UEcOguUoKMbf34vmFdQN6qI43tT/KGxL+qq1aeBuQoJBL+BFYFjYu7Y3ipBbm31DtkQVSBXHBgP/5v9qWhAA7MIrt2uGgnKaq0cQY7E2jCvqQT3dRSTqQ9LGA+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(2906002)(44832011)(41300700001)(5660300002)(38100700002)(8936002)(86362001)(31696002)(36756003)(186003)(31686004)(83380400001)(478600001)(6666004)(6486002)(53546011)(26005)(6512007)(6506007)(8676002)(2616005)(66556008)(66476007)(66946007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDNvdGlpZld0SW8vbUNUNzc1NUZpb3lTMjlsT0N1ZlhuUjZ3ekV1S2wxdVFX?=
 =?utf-8?B?b1NaYkxseDBGTnRPdERUNTU2d2UxZEduQ1haaXdDOVp6Y0JqNHR6d1FQOVhG?=
 =?utf-8?B?eEdleFhzK3dkaWdnNEVPMktHbGtJRy9IMktFWEo4WnZkZUM5c0p1QVZRWXRy?=
 =?utf-8?B?RktFZElHWEJlRmtxZlFSa2RiSnIzcTZmYWF2K0laeDhHd0lLaTJpYlEwMjdu?=
 =?utf-8?B?RExaMnd1OUs2Y0JhMi9YMmdqaU5JM3A0R251WnVzSWY2WllKb2I5c29rNzZI?=
 =?utf-8?B?QVU1azE0OG9Yc1FBWEt4dEU3dktlQ1l5YWhicDc1UmZTbXVnQXNHaDI3cmxR?=
 =?utf-8?B?RUpwMjVidHdYWktHOVQ0b1NHUTlCa3pYV2JYRTlmNXJZVElZSHJlTVIxMG5t?=
 =?utf-8?B?TVhyS2g1WGtPQ0JFcWNUb1JiSUwvQkZPNGRKY2pBbkplR0NaZFdxSDRlYjFD?=
 =?utf-8?B?RlJGTklWYTBMMldPZW1oak95UVA1RmZKSUdBbmlkYTdHY29wT08rRkZ5Z0xw?=
 =?utf-8?B?Nk1SQ21TNjlJdVV5TXU4b1QvUFF6WklDaStYYytuRXFnR2o1YVJOeVVyU0tx?=
 =?utf-8?B?Ny9ocmZjRjZmemtKU1NKNGxBYWY4Q3ZBNVVOaTc4Qi93N2tsekZkckQ2VmlS?=
 =?utf-8?B?OEladFMxZkhlSUFPMGxNTm9Xd1NqbXJwMjBJMDVhOHZ4RjVPbHBNK2NhNDdS?=
 =?utf-8?B?SVA0Q1RIckNTOHIzOVVmd1h2QUlVMHVGVzJKVm5oMWR2SjBVNTd1VlhiK09w?=
 =?utf-8?B?dVdpWkc5d2tNcHJscDVmc0k0eXlMZTArME50ek0wRVByazZiaCsrYitEaHFl?=
 =?utf-8?B?WUFEbnVUZ1MxeXJPTHZ4Q29oQjMwNE1obVIrNUVhOFZScmZYUktOaXk4ekwy?=
 =?utf-8?B?Q3dxTlFpOEExOUVRNUc3Mk9FOGE5bTBoQXh2SlZuc2FnNVR2ak5BSG10Zi85?=
 =?utf-8?B?L3BtdkdPTEoxcTJHMHkyUDIxYk9zQXNtTXZmaVhHWUNGeEFHMkdGNmJ2TDl3?=
 =?utf-8?B?dHRyS2gxZXVjbUZsZ1FlQzI5bHVLbXQwM1JFdGx5VWthQkN5b2pmNGtmaVl1?=
 =?utf-8?B?Vm9NYmpEOHRXVkd5cy9xNXBaMHlCVndWZjhQUVljVEZUNlNwNDJwSFhKaW90?=
 =?utf-8?B?RzRkMlI0WDl3ZERYVlhUYU91OFd3bm5seldyWFNCRzQrbW53MVpIYlZEN0xZ?=
 =?utf-8?B?SUlhYjZ3TWd0L2hSL2k3MnNOQmFrT0tOTjBiUDBCczdtRmRKNUlpWTlQb0pD?=
 =?utf-8?B?Vm5icGd6NExDbTVEbWRLUk8vYUZuOWwrYUZQczNtdWFrTnJNa2ZRSEV1NUhG?=
 =?utf-8?B?Q3h0Sk8zM0xsU2RxSWJPMjdxSHZIVDVBOTVzeS9kdldadUlRLzRDNVY4WnFO?=
 =?utf-8?B?L3hGYnM0UXZ1ZTg3eFpKQ2tnVjIzZnRKY2J0NFgyNlAwd0I0ZytmcjUxL1Ez?=
 =?utf-8?B?S3NXZ0FYNnc3RU41SlowMno4WVlSS09pOXlPUFA1clNzUVlQcDlOV0lsZ3ZV?=
 =?utf-8?B?azY1ZzVRSG8zQityNzVURkRQYk53cWNyOWkybStCdHpBK01qK3lIK3k5Z0hl?=
 =?utf-8?B?eUxheE80NkNGVmFyM3VoQzZVcEg0M1drZnJCa3ZDZGQvb2VqRVdqYzNzNnI5?=
 =?utf-8?B?VXRBOFdXbk9YSktVeW9MSjMzMENrMmNWUm5Ha1QzV2J0TWFhTStzS3ZxcVpU?=
 =?utf-8?B?bnJ4Vlo2VHNmcStBZFBTZUVxVkNIUkhETmFjQ3NOYmtkdVBJcC9XenJvSFlq?=
 =?utf-8?B?a09hME9aVzdUQlRCRHZmU3RwR0VpSGpxaFhIMW1xanJyekdqaktWaDArT05C?=
 =?utf-8?B?UFR6aERXMUlvNlMwaTdSRVc4SUowQVRsSHFRMWdlQlpObWVBVEdhb3hYa2E4?=
 =?utf-8?B?eFlhN29UMGREMmpzeVl5Z3l1SmVPUFoyTEF6QVNOZWtwakxudUtXMkdXMi9z?=
 =?utf-8?B?NTNVQ0x2ZTNEeDlZdmpjU0M4eWdVUDlISVlWVnVpaXJwMGRzZjUxSXBURHVK?=
 =?utf-8?B?bkxzOFVvTUt2TTlWQmhxaWNkejlZMGlvOEwvZU95VmJmSDZIV0xrejV1QWtv?=
 =?utf-8?B?SXA5ZlYvbEYvMmpDRlhaZkhTN3RFNkRnYkZGR0hTUWt5dEVuNjVzYi9MOW14?=
 =?utf-8?Q?PBJz0TrvKhECmGPpGwj7m1HMk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b205f3f-8680-4a3f-c60e-08db2fa9b853
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 16:30:19.3161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1pwH8LylM3zOpsscFJU3rqfHdbEKQ5MQWJSKoCE522DnACUpGdIM5svK46Dv7pl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
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

On 2023-03-27 20:11, Alex Deucher wrote:
> All chips that support RAS also support IP discovery, so
> use the IP versions rather than a mix of IP versions and
> asic types.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 72 ++++++-------------
>  1 file changed, 20 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 3106fa8a15ef..c2ef2b1456bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -106,48 +106,13 @@
>  #define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control))->adev
>  
>  static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
> -{
> -	if (adev->asic_type == CHIP_IP_DISCOVERY) {
> -		switch (adev->ip_versions[MP1_HWIP][0]) {
> -		case IP_VERSION(13, 0, 0):
> -		case IP_VERSION(13, 0, 10):
> -			return true;
> -		default:
> -			return false;
> -		}
> -	}
> -
> -	return  adev->asic_type == CHIP_VEGA20 ||
> -		adev->asic_type == CHIP_ARCTURUS ||
> -		adev->asic_type == CHIP_SIENNA_CICHLID ||
> -		adev->asic_type == CHIP_ALDEBARAN;
> -}
> -
> -static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
> -				       struct amdgpu_ras_eeprom_control *control)
> -{
> -	struct atom_context *atom_ctx = adev->mode_info.atom_context;
> -
> -	if (!control || !atom_ctx)
> -		return false;
> -
> -	if (strnstr(atom_ctx->vbios_version,
> -	            "D342",
> -		    sizeof(atom_ctx->vbios_version)))
> -		control->i2c_address = EEPROM_I2C_MADDR_0;
> -	else
> -		control->i2c_address = EEPROM_I2C_MADDR_4;
> -
> -	return true;
> -}
> -
> -static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *adev,
> -				       struct amdgpu_ras_eeprom_control *control)
>  {
>  	switch (adev->ip_versions[MP1_HWIP][0]) {
> +	case IP_VERSION(11, 0, 2): /* VEGA20 and ARCTURUS */
> +	case IP_VERSION(11, 0, 7):
>  	case IP_VERSION(13, 0, 0):
> +	case IP_VERSION(13, 0, 2):
>  	case IP_VERSION(13, 0, 10):

I'd add the rest of the proper names here which are being deleted by this change,
so as to not lose this information by this commit: Sienna Cichlid and Aldebaran,
the rest can be left blank as per the current state of the code.

> -		control->i2c_address = EEPROM_I2C_MADDR_4;
>  		return true;
>  	default:
>  		return false;
> @@ -178,29 +143,32 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
>  		return true;
>  	}
>  
> -	switch (adev->asic_type) {
> -	case CHIP_VEGA20:
> -		control->i2c_address = EEPROM_I2C_MADDR_0;
> +	switch (adev->ip_versions[MP1_HWIP][0]) {
> +	case IP_VERSION(11, 0, 2):
> +		/* VEGA20 and ARCTURUS */
> +		if (adev->asic_type == CHIP_VEGA20)
> +			control->i2c_address = EEPROM_I2C_MADDR_0;
> +		else if (strnstr(atom_ctx->vbios_version,

In the code this is qualified with atom_ctx != NULL; and if it is,
then we return false. So, this is fine, iff we can guarantee that
"atom_ctx" will never be NULL. If, OTOH, we cannot guarantee that,
then we need to add,
		else if (!atom_ctx)
			return false;
		else if (strnstr(...

Although, I do recognize that for Aldebaran below, we do not qualify
atom_ctx, so we should probably qualify there too.

> +				 "D342",
> +				 sizeof(atom_ctx->vbios_version)))
> +			control->i2c_address = EEPROM_I2C_MADDR_0;
> +		else
> +			control->i2c_address = EEPROM_I2C_MADDR_4;
>  		return true;
> -
> -	case CHIP_ARCTURUS:
> -		return __get_eeprom_i2c_addr_arct(adev, control);
> -
> -	case CHIP_SIENNA_CICHLID:
> +	case IP_VERSION(11, 0, 7):
>  		control->i2c_address = EEPROM_I2C_MADDR_0;
>  		return true;
> -
> -	case CHIP_ALDEBARAN:
> +	case IP_VERSION(13, 0, 2):
>  		if (strnstr(atom_ctx->vbios_version, "D673",
>  			    sizeof(atom_ctx->vbios_version)))
>  			control->i2c_address = EEPROM_I2C_MADDR_4;
>  		else
>  			control->i2c_address = EEPROM_I2C_MADDR_0;
>  		return true;
> -
> -	case CHIP_IP_DISCOVERY:
> -		return __get_eeprom_i2c_addr_ip_discovery(adev, control);
> -
> +	case IP_VERSION(13, 0, 0):
> +	case IP_VERSION(13, 0, 10):
> +		control->i2c_address = EEPROM_I2C_MADDR_4;
> +		return true;
>  	default:
>  		return false;
>  	}

-- 
Regards,
Luben

