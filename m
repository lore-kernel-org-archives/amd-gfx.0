Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75086C4708D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 18:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E797E10E409;
	Tue,  3 Jan 2023 18:37:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09DE10E409
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 18:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkCaQtRKC8gXIecRDSK1zVdGSxkbuv2Gu9OhdPE1kOwcFDm+bZFVG9cTkUmvhZEMKH2qJSEoMlLc5/U6+UklJmIvd41dFwR9hSKMJ79FJObLU7boJ+k6i8W9xYhQy6xe4p9Jb5/1niUyg0EgC40MbqQP/+vlW9uTL0Z5wNXNPqfzQqN0tTU74cDlClyFv8GurP/iPah5rYZJvcz86Oz3MAQuVuzO7dz3yqvr/r9AuRWqSA3+fGYc+SpQfqRe3hR0zr/HDW8U5bdc9gRDY3ObnSeLWUpm1JTTjpAl0uIeCc5ImEFBpXPLIIbs3fG+EBKfhy3KbrN/kbGvBR/m9xYyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SIAGGHRbv8loELowVV6jgK5zPxDmqH1h+lAI9wIYMA=;
 b=PIQbRZkbEr0unzWPRYjsnZmVJayCDXscc1KWTaWLM0fu7w0GjQB2zuBR59IW5XDCR5TcBT/Vy/Jf57a3/JJWZ8ZTO5vqaXAfBGvnfiKPw8Du4CGUZCYhIvehcdf3y7OjyZ967tpbX6CHnk4A8ba8EHtZugHgs0uGYnfoNGwr2f0fFScpamryqD3nojg6AU0ir9zdzhLlUwNb4KPnQ0Pe+Q/xCFdno+mFZStf/MT65U/CqyunU7jsHSDH3j6btdXUvhlx897TXeeFGpG6zE2tbYfSMfV3e4MwNDmN1wHQkMLGVRD538sKRsfBCq/t0758OELAq+IFLlTle3D0NEV1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SIAGGHRbv8loELowVV6jgK5zPxDmqH1h+lAI9wIYMA=;
 b=QZCs/kiimkcRPKhL5TcVYh5GjyeRLiY0TvFjxXz8OdA7SODEJFeYZmz3nTFA99/VtexymhGD705qwtl/SOYggPbDQ3+y5bRqao6e/fbf7A2+KmrYxPAUfTWGnk7fY3oyB+yBnt9hM2zZ7YGYaJ4oRDvef+dI1+92YGPep+v2Eiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 18:37:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 18:37:34 +0000
Message-ID: <a71ce770-7e36-0589-2c47-b0381566541c@amd.com>
Date: Tue, 3 Jan 2023 13:37:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC 3/7] drm/amdgpu: Create MQD for userspace queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-4-shashank.sharma@amd.com>
 <CADnq5_NONiTu2oEEV1+epbuaH985QBbqMKuM9ZDYEn7Ar5a2pw@mail.gmail.com>
 <d19ada1d-86c1-7278-9bf2-a7571c2830e1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <d19ada1d-86c1-7278-9bf2-a7571c2830e1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: be99a095-16d8-4f8e-31c5-08daedb99461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqdZ8GjcqMvnzXoA4uLisB1JuvFDhoToWDIyNryO8flL/63otwBu9yFCofjWooB/35LmpqPe9Pv4ozgnOGmEQQEa/rSO//l8/arECdEjhN+NEnW+kTiPTbA6TzWN719xX0ouMpwS5yyM3TXxHnRGT+0w/uHZ4k0MSNBoWu97GaaitMTbJPUaJOW9fZws5oZhIaotSua2FrMKx2U+tlopACVRHXWkjZQQYFI+CpsmeKXkBf111NFq1a/EAW8COq6tQU/Scs7jH4qr8e5CFgEA4VY0gnMukSEykPjoO+wvjKLV88VI/ion6dfXFh2nk9T+yvg66dJTfSEIRXmGPE6ssvUJ0lM0LSSh45QXiFewmRucJ9hCv2NNtJ6yUTs984kicS1yRDGKkFOJ8sPV2w+vFGmqG25kpHGK6vMA+SKnfxE6h2MQG1dm/RirNK1xgGVmfcJZynMKniJVqpUixbker2UaeyRA2oNt8HLGFAhEdwu8nXSNROSQRM49Rf7Y91hpnvgdCoT4bzKsedBCzNCXuQJ7lCs58rzVAQVBALqkFhChMAU22N5U4SpuZO9CxFcYhPnjO+RgvJTA2p0tpHrpK2g7krltNCU7xZtisX0Eh53NsKc9LXjlPLyMJ2dZaZL3PGPe6tAZyEGM7SaAzKU5FLEjvHe94XyIY7vNC75HdkFWz1BgphqrIwFtWr59QjygEFb+US+qXS1a1K5ha3saYlqN7AHnGNRnwUFQSbnbfnGfzIvEs0bfUSL2XRR4cksXm+O4/LP4wpUrqIoiCh7+FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(44832011)(41300700001)(66556008)(8676002)(4326008)(66946007)(8936002)(66476007)(54906003)(110136005)(5660300002)(2906002)(316002)(6506007)(478600001)(6512007)(6486002)(186003)(26005)(31686004)(6666004)(31696002)(86362001)(2616005)(38100700002)(4744005)(36756003)(22166006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVFSTR0T25zTDJ1SHBzYldGeWV0VEdnMHQxdFJxbHBXam9zc0pVWTU1VEVJ?=
 =?utf-8?B?US96N29iY2RCU0w4aXRBaDFUaFJTeE5BVUpLbUZxbVRHUlhnUFdOaC9hZkFJ?=
 =?utf-8?B?ZTVoL29nY1FFaTlhNkVZWW02dnBIYUw2MlhDbUI4TkdHOXFOaVpZNkJaUEJR?=
 =?utf-8?B?M2d1aUVhOFJrVjh5WlVlVWNQcXptb2NoVW95ZUY3RWtQNWdIa1VPb0VVVjVw?=
 =?utf-8?B?VVJhajJhN1FrN1ZOYS84TWRYZU1PYjZLZ1RSaWlqQm4vRGFhV1poVWlsWDM4?=
 =?utf-8?B?cFF5Qlh3S3NSUkFyQVl2ZmNnalRRSmVJVUpmbEhZQ0hVRlFpMSsvbWMxVzJD?=
 =?utf-8?B?azl4cUdIY0NlWTd5NklZaU9uMmJBR0dYUkRSK1crd2FhZ0FRSk1qUURzS05r?=
 =?utf-8?B?V3FicjY0UkpORzRKVHJrNUxYdUVLUDlYNE8zbDF1bDF6WjlQUjUrTjZzWDRu?=
 =?utf-8?B?RjBNbU45SHJiVmYwd2hGR2FuMThoKzg0ZEYvZEg2QTVZTTdKbEg5clpvQnpF?=
 =?utf-8?B?YXNaWnB5eUNUN0JmdmZBbi8vZ3JoMENBdndoSC8vNFAzRXRBZmYvcUQ2OVFy?=
 =?utf-8?B?cS9Tb01SQUpxSWY3dituRzExaU50YWIwYmJieG5wREMxcVI2KzdVNnZYUTEx?=
 =?utf-8?B?enVNaS9yOERNS1dJNDJ6NVcwT2lwMGtiNTlwaWlBaGNuc0x0ZVVybG1iV3Js?=
 =?utf-8?B?YUF4MGpDQUM1V3AwbDZHYjVVcVYxNFZTRDBsS1hSVE8wN1ZhTS9tV29GWFVR?=
 =?utf-8?B?K2U0elZSVHgrczhVT1orUVN4M2FuTG56MWNaaDFwYldFOVVjR252ZDRaYlZR?=
 =?utf-8?B?N29CWStvbkJrV0ZWWUlYRnNYY3BhSTVhaTdVUVRBdW1DUjJDVU1VYVdkNjUw?=
 =?utf-8?B?VnZaWFFpazd5cElYSUd3WE83VklBZGhyRFVSSkVkZ2UzNUh4eDlsVHljVzEv?=
 =?utf-8?B?bmhhdlZiZ2VzcTRlUmxtNmc5cVFxblh4dG9GVmcrZEh1WnRJd0s5TThucDJC?=
 =?utf-8?B?WHJVc1dYUmFVTjF1eVUwQ0JUb1lpMjdNd2ovWk5XTllSUTMwRzlFOFBDejBU?=
 =?utf-8?B?b0xmdjI3OFMzUjR2R29OQk9oQ1BINTFobndzZXRvNDJzaFhPVUp4WnN6Skpx?=
 =?utf-8?B?c1h3N1lLVmRjbk4wbU92RVlmcU00YUZjN2pQWnR2aFpaWTN0YXRyWW5BV3JD?=
 =?utf-8?B?OWJEb2t1VUNOVExWQWRTWlhhN0dCd2Z6bVlaVnBLaUpnVVh1aDM2ZXVFZURV?=
 =?utf-8?B?Q3ZodGhwZEY4SFNlakZ0YnJNeDRmK01WUnp5QnFIbWNsM1lJdDVUSlhlN3NN?=
 =?utf-8?B?OU5za25oNm1hUE1MTU52ZE1ZVGlSTnhXNDEwYjZtbFl1UnZWcThTVE81Q1hq?=
 =?utf-8?B?Qk5xelRvMjBjdzRLZkVDalJYZTRYSTNuZmZvajVEdm9HYzA5bjdQT2RaZzNY?=
 =?utf-8?B?NWZSbGY0czdIUkhFNWZJK2x4YWUxTExLL3ZPd1RxeFhHY0k1cW42R0NVbzNY?=
 =?utf-8?B?VEY4Rjk3c1hNWjQ0MHlDMGs3Z3Q1cXo5RWgwM3hBVEkrbk9lanVGT1JHcnBq?=
 =?utf-8?B?cGZET1J0djNuWEVaRGcrNkRIL0ZPTFhJaDFiNHcyK2NRdURpVjBtR0FlWlly?=
 =?utf-8?B?YW9nN2F1VDV2RXRQV3FvMU1NWGVOMm9QcjRHZ0U2NUZGWDl2eFF6dnBoNkFP?=
 =?utf-8?B?bzVmVDRab0NFdjgxNkZWNkNhd2JIVU9sQ3BhWSthcGNiczkwOW1xbCt3WVNl?=
 =?utf-8?B?VTQ3ZlNnYXd1YTRlOTRPaGVxcDBkK2JtRTBhdDZ3Tjdhdm81bW83aVc4TjhZ?=
 =?utf-8?B?b2pVTmFVYkZMZk9NSGo4c3UvS3l3ZmVrYkRJRWlVZUxSRU9aM0E5U2NhWDh1?=
 =?utf-8?B?a2U5V3dad3ljR1FZWk41RFJQT3pqQkxqV24rb3JVVEJWZjZlT21sU01rbm5u?=
 =?utf-8?B?L2JCZWpQYmxxQW9ueUF4NFoxd0Z3QllYT2taY3FnYXZPREJQSi9QTkw1Ty9o?=
 =?utf-8?B?RmZJazJVeHJIK25LY0Q3YytWRk4ySXZLZGVoSXYwSlpxN0FLV2xxdElaQU1I?=
 =?utf-8?B?RGpHeEl4ZkVxL0tnQ1h3ZnNpMFNVMUFJb2h2cXlRYWxnUTMrTHAydFpQakxE?=
 =?utf-8?Q?FCojvyH14bfC3n+RZY0Ut/Qw3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be99a095-16d8-4f8e-31c5-08daedb99461
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 18:37:34.5471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOGGqg3Aslvlilzf7mGKJmq35hwZu2VYaxGkm60yXBl97/lA7jGJ971jETGGb7j1BVUN2OyO6/bgCpJkuiA2xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-01-03 um 04:36 schrieb Shashank Sharma:
>>> /*MQD struct for usermode Queue*/
>>> +struct amdgpu_usermode_queue_mqd
>> This is specific to GC 11.  Every IP and version will have its own MQD
>> format.  That should live in the IP specific code, not the generic
>> code.  We already have the generic MQD parameters that we need from
>> the userq IOCTL.
>
> Noted, we can separate out the generic parameters from gen specific 
> parameter, and will try to wrap it around the generic structure.
>
> - Shashank

Is there a reason why you can't use "struct v11_compute_mqd" from 
v11_structs.h?

Regards,
   Felix

