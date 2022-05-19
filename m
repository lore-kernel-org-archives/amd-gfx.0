Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB75FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 20:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F3711A8E9;
	Thu, 19 May 2022 20:45:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0618B11A8EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 20:45:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kzch83VddwSETLci5G1WXPla9SEd3+gC9K0VYapDVEJjSbjgmOgPjE7z2oA4/5Kh9tCHIC+iHuVQ9UBnv/+Et/T2cNdg5sNiriMXsB3FGSaoVM5AVS0LQNmyjTosCk6PEffNKNZctctnFXh7vXU5SfR1UR2kRpiqP+BEoI74Betr1uI4meHxqOEcsboBrr1WdFBPfKV3PGfx20XQJ7VS9Z93kf863gvzPWBHgQAEc+bUqF1RN7TbOd/0helLmxQiRgx+MLAqKazuDX8NDGZeEotTiI9zKZA4C0HnaJNozDWzlhTxuGcww/YcZn8MiVn2u2/g/e7ZLFVaoHbyo2BplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCEVfweHd8vu91On2oM595/XB1igz+NpErSHuclD7Bo=;
 b=JaAFWSRReYuJ447tpldiJAahfod5d3VyJXYwjg6llLjtNlXAHoburx2dPDMbeXhhVpHp3IRFyhecyJSC1hqXArFV+bW7iMzIRvN3AS4tVaOlpnK60IKoWQROOhp8gRIxpVZp5WVx+D5pKXjhgupr6xLKd/DRYLXxHja/v7Js8TStkaCu6KGfnjIJssWJpePJ2925xR4VVy5PUfeVbu7N0Ze1ZZKXGJ9H1RN4201Pb4XN/D+7awTBsYXwzfhZLRZHQ/WN47lbM5d1KYHenKVJFrxRxNwmylw7IWQ7GnyJ1F5BDoYrRyjotFNEZTiSIWbhtwzMxTPV/Oq6XOGQTCMShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCEVfweHd8vu91On2oM595/XB1igz+NpErSHuclD7Bo=;
 b=ZH9bejFusV8dg/xKHP31Woi3MIXtVKzIgRyGCt+Pgr5JLVzIBxt6uo1MtN6phIo8xEcePwOnAGDlV8mrUD967b8UT+a+9XxAytExRx36WpV2ODf/t9IAVfQFXoWAzdXdI4Z0U3u/T/Ybmqll7FQ+zQDrYmAJYHN5e8YzAJmUEmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH2PR12MB4891.namprd12.prod.outlook.com (2603:10b6:610:36::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 19 May
 2022 20:45:40 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%7]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 20:45:40 +0000
Message-ID: <3bceb02a-45d3-352b-358b-aa0b57e2da5f@amd.com>
Date: Thu, 19 May 2022 16:45:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] drm/amd/display: add Coverage blend mode for overlay
 plane
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
To: Sung Joon Kim <Sungjoon.Kim@amd.com>, sunpeng.li@amd.com,
 rodrigo.siqueira@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
References: <20220513202200.4698-1-Sungjoon.Kim@amd.com>
 <8b8c0c85-1d79-5cfd-f0d2-ebc8b732e0c9@amd.com>
In-Reply-To: <8b8c0c85-1d79-5cfd-f0d2-ebc8b732e0c9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11c446b0-0eb2-419b-45f8-08da39d88935
X-MS-TrafficTypeDiagnostic: CH2PR12MB4891:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB489163CE9AC130D2EE80716F8CD09@CH2PR12MB4891.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyvD0OwjVdMK5kNN6x1hnMzh8LmtbZ6Vxcn21bikk3SnMdDLayiYs9wXFgPx2OkyBf3ga+ttTJ7RnFSD8q+sJnISrZQnTfiIs4HWjPMpSucnLH/4xkHRdf+Jla9Ni1O4E5dsifzd0Hv4/+M0dNFsXGEtYC/Qs/mrqJHyxYPSXoCn2/t1b7rbhkPQ/Ory0h6jiu8YAuFzPNufL0JjJy1AJPYaH8TkeD1LqZQw8Y6a6gkyfgrxS7SIpj9K1wm1oD1+b5gof0NDJrCH0RY2+hOmvc7R0Dkut2VdDKeWla8Fzue4GWpOz87JFlin4N1p9DjDdLA4Rce7eN6atWX65tJ/+t0fGXUrxpjpkM5t/pM53UDip5uGgH2ZmKVlys46jOQVu4agAXrTVOZegyrFVQODIm5uKN5F6ROD+bRvxacKC/02cqjCoWzRlyIvTwi9EJJrkSDX5SvNC3Oice7yBMn/j4OmD4g98rUdVNDS4k1wLhBAvK2f1blYtq1lYVUAiDC1nmuBY7CP3ArmPGWyqpXCfOa9lr7fkwq0SFp7hPWip5hYti2YWVZEXErDaZ2ehOKCdaJ1pGkH+yoEySHNoaHsIrwQypgRWWkyie4uG4hUS6fqAE6HkHohD77bHYl5oAEH2j6riTqtuzxw9+M67YAvXVvVeKVyoKQ06JuScxppyw+rNkIJp8DRtHjUH5SjQRhm+pXMNG3tZqkXXVwMl+LgpwLVUyGZKp+KHb9ewwAdbNEAlbnnqL2fShOIV6cq3Rcw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66946007)(66556008)(8676002)(66476007)(31696002)(6506007)(26005)(2616005)(2906002)(31686004)(53546011)(6486002)(316002)(6636002)(508600001)(186003)(5660300002)(8936002)(6666004)(86362001)(38100700002)(44832011)(966005)(83380400001)(36756003)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkd0OHY1ZndPOC9kWURZOFIva3l6T1gyTEl4ZUo2bGRWMzFSRWl2S0d3ZFU1?=
 =?utf-8?B?T1F0bXd5SVo2N3hKUXp5RGFPcWlKRW9naEJLT2hucXFWR3ZaaXMxYk5abEVB?=
 =?utf-8?B?U0w1a25qaUMzSUlGc3VPa2JsOVIxbGFUOFkvOGNnQlhOVEVMUmNtZjRBTk0z?=
 =?utf-8?B?bUZwSW5DQ0t6aWU5cUYwNldoSXlmU0pERHFpbGt0ZU9kcjJVSFhuSHhBSkRv?=
 =?utf-8?B?V25vUHFJVXJSQndpNVZtTGN1MmpWK1lscmwzZ0xXa0N6bVVGUFVzOGgyZWNC?=
 =?utf-8?B?U05BampGMUVsUCtTTXNmQzVqQmVoZERrbm5nczFqYmx5Q3lBcmxwRDVXR1hT?=
 =?utf-8?B?SWovMWY4dDl1cXJZSnZXM3g5MGgrbkI1RE1SQWZaQTRDL1gvRmVhbndEUGpD?=
 =?utf-8?B?b3lXdGt4WFM3UkhnWE9BUGJ2RTBJVi9kc2ZFSDRFQldNanpNNVMyejB0ZlFB?=
 =?utf-8?B?RERGbXRvcFdqVnlPTWs5TndzK3diQm9RVUVoOHJrNWt2bS9qTHdmU2JMZ3RI?=
 =?utf-8?B?NXZSMFZueGpQclh0NCt1ZzFnQlZjRWN5NFQxWmVvVGs2dkpkd0pCRElwTmww?=
 =?utf-8?B?OFhPYzVuZmtKK3VqS2R1NmhTOStYaWpZcm45VFdzeUtDY3cxNUdCQ1dCcjdk?=
 =?utf-8?B?Z203MG95QXREc0Uzd0dvNGZuWVd1NzdYRjZzSWtiT0VMNlpwNS9hQmZCdWl5?=
 =?utf-8?B?WTZmaDB4cnNBcEJ4OUhtVUdvU0grTmtRL1BySHRaeFhEa1YyU0lOUnpZbGhC?=
 =?utf-8?B?RzVucm1laTN1OFJyUTJlTldaS1FJNjZQVEs2TzU0YVNCYzJDWHh0QkM0Mi92?=
 =?utf-8?B?R2ZOZWdxQm5TcGFqYnFudU5OZytXbG5OWjNFYmxGbzFCc3o3bUZ4S1JQUWRW?=
 =?utf-8?B?NFNUcVIrS2R3VHNqbWNWSkQrVVVBYjZDQ0g4TGFKOFJ3VC8xRzVscTVJb2JX?=
 =?utf-8?B?RUJoalVpU0t6UytYb2lmdVJZZmdZWWhpUnpMMHdJQmRvMUs1T0kwTDAxcmRN?=
 =?utf-8?B?Z2crczV5SnEwWEI3cnRPU1drM1pzY3hqL3lEUVM5Smc2V2hpbCt0bXd0QnRr?=
 =?utf-8?B?NGYrL2JNL05ocDZtRUxBQTdYRm9XNmVJeGM5emlJTk8xL1JoRGNITG0xR3RL?=
 =?utf-8?B?L3EyVUxpdTRGWFR5QjlkSWtGWDdYZnZ5ZDV5LzJNdC9HMnJUVy9kaHRCZm1Y?=
 =?utf-8?B?ems4VElKdWUxTEV0VWtFblREclVXNUw5YkVaUGFqNXg3SjJhUnlrZDBrTjNk?=
 =?utf-8?B?WkluM2MyQlQyTEhGQWdyZ1NEY2JUUzBvYW1oMmpSb2xmVDYyQU01RGsvd1Jn?=
 =?utf-8?B?aGZRZEEzOXlMWlhPSC9ORjFDRk9FL1F0dG1IS0ErOUZweFM3R0pnTENlUEtC?=
 =?utf-8?B?a1ovUUkwSzRIVmtWUTk2VU8vZ1FWc2lOWkpOcDFEL3BIM0VYbzFRajZTYTBL?=
 =?utf-8?B?UWsxZ243Smk0Zmc5ZTZoWVJ2c1psbmVpWm9McEhnMU9zQUVkZGJDcmJZdUps?=
 =?utf-8?B?YkZSUnNFMW10ZDR0dUFIUGpONmNFTlBWREluYzREcnlrcWF2QnM1S08zZHc4?=
 =?utf-8?B?VUZlVjNaOWJMNDd3RkkvN3VKVFpSeDFEbGdqR3A0eTM5R1B6ekZWWEhjb2Nx?=
 =?utf-8?B?MTZJZzRscFNGSUNiK0pJbEtZMEIvc0JIVVczeTBMeXpiaDVpUVNPUEt5YmdP?=
 =?utf-8?B?N01XVVRIcEdOS1FCT3kzSVJMd1NMdnFPaUZYb3I2WEFKQU1xa214RWhkeXRy?=
 =?utf-8?B?SkVzSzlqM0pBaFBnTW9xeTNLUEN3WThKOXZ4bXd5OUR6OGtZZjVMYU8rSEtQ?=
 =?utf-8?B?bDRKSUVqOUhNQU10eWxOU1dSZ05vN0x0bDc2cW1LTkdnTGw2eG5MOGZYaWZR?=
 =?utf-8?B?bElGZE95MFNOK3dpd29wY3NpLzNzbU0wQkErbFFBQ00ycWNORnE4cXJLM2Y0?=
 =?utf-8?B?cm9yTUJodHVlandsbkdFNzhRUmwyc21BUlBMTVhTMTU3N2J0YmtZckJOb3dF?=
 =?utf-8?B?NzNkQ00wL1puQlB2aytseXdlc2l1YmNnRk9UbDlqNXlaUzRFVy82MU1PVy9q?=
 =?utf-8?B?V2VEcUZ1dEFXd0xXSzVUWHhxdHZrVXJwd3ltbHlJR1VJR2IveUQraUl6Z1h6?=
 =?utf-8?B?cGl6R1dQY0dMMnlJOGhsbzBnd3o3cWR4cm1uVHJOVWVMWmJFSUFlNjdPUVVF?=
 =?utf-8?B?N2lqM25XbFM4T3RUbTIyeGRxU0w0eVluMER3LzViRnNGVDk0NVZQV0h4UE42?=
 =?utf-8?B?QlZKT0liOFZVRlI4RE9kTTc3YnUzTDlVcDlLbmJxK3ZLUDJ3UDlBMXRqNzlp?=
 =?utf-8?B?anB2NktDWFI0NGo1UFBKaDJOaXdPdWJzWEJEVTFYOEJONFNod1pOZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c446b0-0eb2-419b-45f8-08da39d88935
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 20:45:40.6691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VGTLeJ/qX4M+ATqUIZJNC8Cbv14QgEJcI3o3zlZY6Nu2QZ6yiRsI9K959wib8q9+Ql7Gyj+sTPZinp47ardcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4891
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
Cc: mwen@igalia.com, contact@emersion.fr,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, markyacoub@chromium.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixing amd-gfx address.

On 2022-05-19 16:42, Harry Wentland wrote:
> 
> 
> On 2022-05-13 16:22, Sung Joon Kim wrote:
>> Issue fixed: Overlay plane alpha channel blending is incorrect
>>
>> Issue tracker: https://gitlab.freedesktop.org/drm/amd/-/issues/1769
>>
>> According to the KMS man page, there is a
>> "Coverage" alpha blend mode that assumes the
>> pixel color values have NOT been pre-multiplied
>> and will be done when the actual blending to
>> the background color values happens.
>>
>> Previously, this mode hasn't been enabled
>> in our driver and it was assumed that all
>> normal overlay planes are pre-multiplied
>> by default.
>>
>> When a 3rd party app is used to input a image
>> in a specific format, e.g. PNG, as a source
>> of a overlay plane to blend with the background
>> primary plane, the pixel color values are not
>> pre-multiplied. So by adding "Coverage" blend
>> mode, our driver will support those cases.
>>
>> Reference:
>> https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#plane-composition-properties
>>
>> Adding Coverage support also enables IGT
>> kms_plane_alpha_blend Coverage subtests:
>> 1. coverage-7efc
>> 2. coverage-vs-premult-vs-constant
>>
>> Signed-off-by: Sung Joon Kim <Sungjoon.Kim@amd.com>
>> ---
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 17 ++++++++----
>>  .../gpu/drm/amd/display/dc/core/dc_surface.c  |  2 ++
>>  drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
>>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 27 ++++++++++---------
>>  .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 16 ++++++-----
>>  5 files changed, 40 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 2ea20dd7fccf..af2b5d232742 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -5380,17 +5380,19 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
>>  
>>  static void
>>  fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
>> -			       bool *per_pixel_alpha, bool *global_alpha,
>> -			       int *global_alpha_value)
>> +			       bool *per_pixel_alpha, bool *pre_multiplied_alpha,
>> +			       bool *global_alpha, int *global_alpha_value)
>>  {
>>  	*per_pixel_alpha = false;
>> +	*pre_multiplied_alpha = true;
>>  	*global_alpha = false;
>>  	*global_alpha_value = 0xff;
>>  
>>  	if (plane_state->plane->type != DRM_PLANE_TYPE_OVERLAY)
>>  		return;
>>  
>> -	if (plane_state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI) {
>> +	if (plane_state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI ||
>> +		plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE) {
>>  		static const uint32_t alpha_formats[] = {
>>  			DRM_FORMAT_ARGB8888,
>>  			DRM_FORMAT_RGBA8888,
>> @@ -5405,6 +5407,9 @@ fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
>>  				break;
>>  			}
>>  		}
>> +
>> +		if (per_pixel_alpha && plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE)
>> +			*pre_multiplied_alpha = false;
>>  	}
>>  
>>  	if (plane_state->alpha < 0xffff) {
>> @@ -5567,7 +5572,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
>>  		return ret;
>>  
>>  	fill_blending_from_plane_state(
>> -		plane_state, &plane_info->per_pixel_alpha,
>> +		plane_state, &plane_info->per_pixel_alpha, &plane_info->pre_multiplied_alpha,
>>  		&plane_info->global_alpha, &plane_info->global_alpha_value);
>>  
>>  	return 0;
>> @@ -5614,6 +5619,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>>  	dc_plane_state->tiling_info = plane_info.tiling_info;
>>  	dc_plane_state->visible = plane_info.visible;
>>  	dc_plane_state->per_pixel_alpha = plane_info.per_pixel_alpha;
>> +	dc_plane_state->pre_multiplied_alpha = plane_info.pre_multiplied_alpha;
>>  	dc_plane_state->global_alpha = plane_info.global_alpha;
>>  	dc_plane_state->global_alpha_value = plane_info.global_alpha_value;
>>  	dc_plane_state->dcc = plane_info.dcc;
>> @@ -7905,7 +7911,8 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>>  	if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
>>  	    plane_cap && plane_cap->per_pixel_alpha) {
>>  		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>> -					  BIT(DRM_MODE_BLEND_PREMULTI);
>> +					  BIT(DRM_MODE_BLEND_PREMULTI) |
>> +					  BIT(DRM_MODE_BLEND_COVERAGE);
>>  
>>  		drm_plane_create_alpha_property(plane);
>>  		drm_plane_create_blend_mode_property(plane, blend_caps);
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
>> index e6b9c6a71841..5bc6ff2fa73e 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
>> @@ -61,6 +61,8 @@ static void dc_plane_construct(struct dc_context *ctx, struct dc_plane_state *pl
>>  		plane_state->blend_tf->type = TF_TYPE_BYPASS;
>>  	}
>>  
>> +	plane_state->pre_multiplied_alpha = true;
>> +
>>  }
>>  
>>  static void dc_plane_destruct(struct dc_plane_state *plane_state)
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
>> index 26c24db8f1da..c353842d5c40 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
>> @@ -1011,6 +1011,7 @@ struct dc_plane_state {
>>  
>>  	bool is_tiling_rotated;
>>  	bool per_pixel_alpha;
>> +	bool pre_multiplied_alpha;
>>  	bool global_alpha;
>>  	int  global_alpha_value;
>>  	bool visible;
>> @@ -1045,6 +1046,7 @@ struct dc_plane_info {
>>  	bool horizontal_mirror;
>>  	bool visible;
>>  	bool per_pixel_alpha;
>> +	bool pre_multiplied_alpha;
>>  	bool global_alpha;
>>  	int  global_alpha_value;
>>  	bool input_csc_enabled;
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
>> index e02ac75afbf7..e3a62873c0e7 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
>> @@ -2550,12 +2550,21 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
>>  	blnd_cfg.overlap_only = false;
>>  	blnd_cfg.global_gain = 0xff;
>>  
>> -	if (per_pixel_alpha && pipe_ctx->plane_state->global_alpha) {
>> -		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED_GLOBAL_GAIN;
>> -		blnd_cfg.global_gain = pipe_ctx->plane_state->global_alpha_value;
>> -	} else if (per_pixel_alpha) {
>> -		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
>> +	if (per_pixel_alpha) {
>> +		/* DCN1.0 has output CM before MPC which seems to screw with
>> +		 * pre-multiplied alpha.
>> +		 */
>> +		blnd_cfg.pre_multiplied_alpha = (is_rgb_cspace(
>> +				pipe_ctx->stream->output_color_space)
>> +						&& pipe_ctx->plane_state->pre_multiplied_alpha);
>> +		if (pipe_ctx->plane_state->global_alpha) {
>> +			blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED_GLOBAL_GAIN;
>> +			blnd_cfg.global_gain = pipe_ctx->plane_state->global_alpha_value;
>> +		} else {
>> +			blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
>> +		}
>>  	} else {
>> +		blnd_cfg.pre_multiplied_alpha = false;
>>  		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPHA;
>>  	}
>>  
>> @@ -2564,14 +2573,6 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
>>  	else
>>  		blnd_cfg.global_alpha = 0xff;
>>  
>> -	/* DCN1.0 has output CM before MPC which seems to screw with
>> -	 * pre-multiplied alpha.
>> -	 */
>> -	blnd_cfg.pre_multiplied_alpha = is_rgb_cspace(
>> -			pipe_ctx->stream->output_color_space)
>> -					&& per_pixel_alpha;
>> -
> 
> Could this break color management use-cases on DCN1.x for Windows?
> Dmytro Laktyushkin added this code 5 years ago. Maybe check with him.
> 
> Overall I like this patch but let's see if we can confirm that
> this won't break DCN1.x on Windows.
> 
> See commit ad32734699da4dd185405637459bf915a4f4cff6.
> 
> Harry
> 
>> -
>>  	/*
>>  	 * TODO: remove hack
>>  	 * Note: currently there is a bug in init_hw such that
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>> index e1f87bd72e4a..c117830b8b9d 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>> @@ -2346,12 +2346,16 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
>>  	blnd_cfg.overlap_only = false;
>>  	blnd_cfg.global_gain = 0xff;
>>  
>> -	if (per_pixel_alpha && pipe_ctx->plane_state->global_alpha) {
>> -		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED_GLOBAL_GAIN;
>> -		blnd_cfg.global_gain = pipe_ctx->plane_state->global_alpha_value;
>> -	} else if (per_pixel_alpha) {
>> -		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
>> +	if (per_pixel_alpha) {
>> +		blnd_cfg.pre_multiplied_alpha = pipe_ctx->plane_state->pre_multiplied_alpha;
>> +		if (pipe_ctx->plane_state->global_alpha) {
>> +			blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED_GLOBAL_GAIN;
>> +			blnd_cfg.global_gain = pipe_ctx->plane_state->global_alpha_value;
>> +		} else {
>> +			blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
>> +		}
>>  	} else {
>> +		blnd_cfg.pre_multiplied_alpha = false;
>>  		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPHA;
>>  	}
>>  
>> @@ -2365,7 +2369,7 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
>>  	blnd_cfg.top_gain = 0x1f000;
>>  	blnd_cfg.bottom_inside_gain = 0x1f000;
>>  	blnd_cfg.bottom_outside_gain = 0x1f000;
>> -	blnd_cfg.pre_multiplied_alpha = per_pixel_alpha;
>> +	
>>  	if (pipe_ctx->plane_state->format
>>  			== SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA)
>>  		blnd_cfg.pre_multiplied_alpha = false;
> 

