Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E14EC3F2D2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 18:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F7A206E2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 18:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AecibBjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F7A206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F926E38A;
	Thu,  5 Mar 2020 18:56:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770040.outbound.protection.outlook.com [40.107.77.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD526E38A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 18:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd8mPM2oCCM4sawBFZQbH9eFlfM+5h9N/ovwN+7wbm2egaAeV5sJLayZc39Nj+TVGMA2BsMzvouPsIrBEywZOCy+WTqI8D2qtJGjj9d4IP0Xblr1iGbTlAqh2HkAwBZs1uCsWkXFqxy3XPzjBag4hlaXu/SQct6HFdz0eUyGFr7Xd3qs8IyZeJCfYl7DG5edMEZuIXGQLqvgMAPFZl4MD1A8T62nVVj6TUDA0l99kNCboOdGro+WtSCALYUmfPdkysAGGB4QBeW4+IhoMWFRJfyIuWrt6ubRy9bg8HEkb4/uKV2cl1mlGNwEccrxOcPryCQZacj2ty6jEHMgtgHPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ory8wtMHjhhGRk63AdtrgkEzlZ35LdSppaNQir1LIk=;
 b=YwBhVQhmI6JWoW/cm0aKwgXs8IxUkOIA8eTYZD4r2UGDf8nbYVERZnq6RYBJChIetZEqKnfffA6f6zkMQVigLro1VUCJFXhc/iXLhYFA3GoUyFMKe1rScD5CdpT10W6YZslmWoLXyBQk5FhgtI/ND3e7L+fHuDI7OG4G0NWP3gumMB10V4FGip0ZoClOH5piVfikwxxh/QnaoZcqao8aODsL8GJzTE5VnfcwceULypDEQnpfCCoD9dZ1PvBDWiu1bwIkXfiDlscZu0BGzrf7bRgha87LlHzlnbAAWSHtpdjf+EC/D8S3nCN6XKsILfI0kYi/D67zzYdZBvv5YyeUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ory8wtMHjhhGRk63AdtrgkEzlZ35LdSppaNQir1LIk=;
 b=AecibBjzbckNz2Xr4Su6uWVL7O4i7IOgrNou8xTLHVGgUVfXOMVXj3rQeb83D+eY8OUBDXeoDDukeXcodN08jfgQ54wumY67wyTTszbUwkI977Wx9DTnTI3YjFa41UQFT628gTHaoPXOmBI2a5+6iUOGwHfPY87yDurrXRrisRk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Thu, 5 Mar
 2020 18:56:19 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 18:56:19 +0000
Subject: Re: [PATCH v2 2/4] drm/scheduler: implement a function to modify
 sched list
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <20200303125039.53141-2-nirmoy.das@amd.com>
 <dbbe81d7-ff99-b85d-ddfd-1f3f13322d53@amd.com>
 <7b01f363-5048-308e-e51a-9391d4dd58a6@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <07131f2d-b695-c203-6a97-4295c6ea86e8@amd.com>
Date: Thu, 5 Mar 2020 13:56:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <7b01f363-5048-308e-e51a-9391d4dd58a6@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Thu, 5 Mar 2020 18:56:18 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3fcfaa09-96c4-4d5d-6403-08d7c136e409
X-MS-TrafficTypeDiagnostic: DM6PR12MB3305:|DM6PR12MB3305:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33058C5F1117279C24285F0999E20@DM6PR12MB3305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(189003)(199004)(2906002)(4326008)(478600001)(66556008)(66476007)(66946007)(5660300002)(8936002)(44832011)(81156014)(4744005)(956004)(2616005)(8676002)(81166006)(316002)(31686004)(186003)(26005)(16526019)(6486002)(110136005)(16576012)(36756003)(86362001)(53546011)(52116002)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3305;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdpwC/2ecQOi6pzrrKSyLbompZT1bH1bFYBLtMi68qiC5t/oxdh2MgWWQGFNzddJJhzcPcAI5/RNF9eDbVZPkF3HfDCHUTt++ld3bd9uc8WX3YoWFnGzUT5X8uiPv2kUIADtutGW/JdNJf8vzueFEBmWIk7C9/75hmsTdWzQCaMbLw+G1kIB+mgdFxqaoIOjTVXUudcHF4tb9a5L/cnMdWkMVkzPcd3rcBJhy5dD8BNkxUfK3IwXO8J+jlVTFIel0IxWRZWZSAGrKbHSZvN+r5rFejeYJ34RbPKrkI6JxfGOiZ1eUiICR7ofJvDYhMpNlsSVlzmleo1vrbdES4O5hSjD0gzFKF7xfUZyTUlWsT+VCXX5VHBhPcX0qUQcOjUYnH+3Iyf1lYoSMffFBu4JqnALJZVlfxdUB09rhGcDdu+OyYqVsJDAC7lnXVL44rrD
X-MS-Exchange-AntiSpam-MessageData: jP+i7fpLgmfSrGis5PQxL5qCJ3pjfHt6mAZ+qI4UniGOEs+UINehLOBrKd6PGOMloy/ljkZ67aNJjYLNVPXbg1n8P7O5SDgsF3l5tgfja8gB7QpCp9wVDJTpILJ/cWMqnR6S5R7reWyglM7Cn9eWgg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcfaa09-96c4-4d5d-6403-08d7c136e409
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 18:56:19.6039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEAbf+2CO8cxW9Pi0lbsrtdCvYt6Q83LwT/qHMnnVJ0aIp177TESAWD+VAXgducK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3305
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-05 04:10, Nirmoy wrote:
> 
> On 3/4/20 11:00 PM, Luben Tuikov wrote:
>> struct drm_sched_entity *entity,
>>>   		       void *owner);
>>> +void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
>>> +				  struct drm_gpu_scheduler **sched_list,
>>> +                                  unsigned int num_sched_list);
>>> +
>> Again, the argument list here is unaligned. Please align it
> looks good with cat and vim. Not sure why git format-patch is acting 
> strange in this case

You mean, "cat" and "vim" are acting strange. Then don't use them.
Use Emacs. It's easy to use and you don't need to switch modes to
edit.

Regards,
Luben
P.S. Please surround your replied comments with empty lines.

> 
> 
> Nirmoy
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
