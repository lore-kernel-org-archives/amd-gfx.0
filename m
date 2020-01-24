Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03D4C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 11:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D80206D5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 11:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="To6Ut7Fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D80206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138326E33C;
	Fri, 24 Jan 2020 11:51:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337066E33E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 11:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuz/fvTj7eW/utwQrA4oCJ1yqXFXaljRhomf88L2PPg15+yskUKNgxj3yp7b28KPhS1C/KTHCcS16IiQ+QI7RQkUzSRa5RKOWhETYsnA8jc8YRHJLaIB8Ur8TgaFxEMjqn8yoTkW7U3gcl/UzXD/l9E+pq/+R9Pq+Off+s7mti+euCkMoJ/v/Hp3E305SLinqMUVbWLptbSmdAI3TrU+Kp6EcFS2q4gtvVNBxXWEolFSSKNH+KLLP66lDkf/IKGn7AVlClvJ0WSMf9BnkwG09Ze7mCU3S92Zo9+EQ0ZbKxhQPuQ9kK89eDmAXliBLV7Ha1i4adTFQTPCm4K2HEQCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNT2ZDDjD1JyEnbV5ujZLyvFp2xwggSkp3vbxTBd1P0=;
 b=PUmrcxB4TxMO1GHfxstZJr3Yw6FhRjgOdSjM8+HguqusPGX65nvGz+FZlnzIT0MAcEU7x155Xu5UqpfrtZUB6mrA6omEJQdhK+2afnudC6g6XMNXV4TOyTl+E4iJDOgnAa09/65o6zvIfNYaIL6UXc/8CJ2peA9ksaY7eyKc4+LjwsJ6xqpaWibTQIYZpyO/L8147HfcjY94Ems/OXJDml86BKxgtaEy5W3J/cDPu8QbcXjeL/7Q3OLNZFMasBGrOg2W6Bzts+6DY2am3n3qdzGdU4b9AOIyNTJXOBEBznqqBwHl1vbILdI4WtJLdulGvvtSbVrhJeZ//d/IJWO5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNT2ZDDjD1JyEnbV5ujZLyvFp2xwggSkp3vbxTBd1P0=;
 b=To6Ut7Fo+VZdAhNDcI6Rt8JFp1iCuthN8Bu+Fyziab23hyWvLlHj1cywVg9Nr0mYycW0Dz1iZQXeDMC1q3PKXf8ukB4sTYghROXZdkYQRluJnxBOX+xO3KgmSLdIKlYJNU0/1Wepm6ETtBaXb+Avzzl6zcjM/Q5hsAmsx/ENltA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB2389.namprd12.prod.outlook.com (52.132.141.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Fri, 24 Jan 2020 11:51:33 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 11:51:33 +0000
Subject: Re: [PATCH] drm/amdgpu: allocate entities on demand
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200123161300.31237-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <61cb7223-e6ef-6f91-f252-1e560e6199b6@amd.com>
Date: Fri, 24 Jan 2020 12:53:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <20200123161300.31237-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0041.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::21) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f2a:4600:f739:b646:7d2a:1c91]
 (2003:c5:8f2a:4600:f739:b646:7d2a:1c91) by
 AM0PR10CA0041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Fri, 24 Jan 2020 11:51:31 +0000
X-Originating-IP: [2003:c5:8f2a:4600:f739:b646:7d2a:1c91]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c23aac7-8e0f-4991-9c17-08d7a0c3c1d7
X-MS-TrafficTypeDiagnostic: DM5PR12MB2389:|DM5PR12MB2389:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23891EAA16CF0E2E90A5F0C98B0E0@DM5PR12MB2389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(4326008)(52116002)(2906002)(31686004)(2616005)(478600001)(186003)(81156014)(31696002)(81166006)(8676002)(16526019)(6666004)(36756003)(316002)(5660300002)(66556008)(558084003)(53546011)(66476007)(6486002)(66946007)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2389;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uX7AuIw8E8M9oE5+QuVm4kbjg1UR7kOW7ewP+F0MY4+h+nT79zgdKzexpiCF9Gv5OaFBbP+L7TWr5wmzrU1WQ9Cov8mYicaZ+2Nh3wrG28eMmOh0F0oY8cvVCkmDGuFPhDnC/+4XPxnaX076zmvSWx1HoA2W5Um9TQqKVZgOHqT7Q++64RcNbhmBDJ8tQtB7cz1qOoLpSvFWRbX9rPYeWBDt4ACHsBcH28Moufk4eo1hM9o00dmYyFPYwAKTYdIu5FusV4LoSDBsAFwXQhQ8ylDBQZpBtDp1MiTeuZaE0SNgQURQ8ExfOsIkYx7WQS2z6jkUH+n3zD+pn5EWrQ+73MbmgZRtznCUYjSIDGssvjRfteO/x3SFUARxRUX3k+yzWI7gSnxM/u2nhOl71/9LF2wFsT0nfpH3VxwJvR+aOY0w7DrddToL/CCUj7Kh4b72
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c23aac7-8e0f-4991-9c17-08d7a0c3c1d7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 11:51:33.0642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGP4F8vTLsXJfnZngCcP6D8ARIfuLxrtt8O0lFG6tX3YS9+eKnk4qy6JI6X7tydHM2GJpAN7yUzMKUrFL5B4bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2389
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/23/20 5:13 PM, Nirmoy Das wrote:
> +		kfree(ctx->entities[i];

Forgot to add change that fix ^


Regards,

Nirmoy

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
