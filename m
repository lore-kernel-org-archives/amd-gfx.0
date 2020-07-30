Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ECBC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 07:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E47206E6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 07:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xcCHI7VK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E47206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B2E6E87E;
	Thu, 30 Jul 2020 07:24:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F5D6E87E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 07:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIl7wFqaVz0fGD35uyHBSsAttN8lqO/J+4XvtiUE2ifl0lvgOzqsGg0An3+cXEiDuze9C3gpwbYqqXW17iDmf2s1ZWO8/hmpX+QVlegCmCNzSDzgOuYnXjKqrdxwYLuH9Y81RAE1eLoOacL7ZD2aHPBY4L9ReAb2LQlKSaZ7uiEP5RVO8mjndEHd0t+hx2+SrvoYIcykvXd9STNTeVPcJtn4Z6cAOLYx2ou/l5aHsizUId29tkknlU0u9BZwsK/Nij5LU6lQ/hdIRKA9FfLMNvwnbKiDTiHX/szoalJs9rWKzYReVvhjTuPaIng/xplOq0+7RkLo7erDSDihtPZ6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ba5OU5sg2Nf4gWoqjS/jo82/CH7hpIVy8hpW4XhmMk=;
 b=faMos1/vzHnU9PdrVpaG/Mcg36ennDKNWbO+X9MgrHuCVL8uXp6B+8hKvRaOVl4Om+VC+rE8AF4SOl+TE9PAm6b6DzzaSQPYf5GQaO6Y0f/E46s/JqRVTwCgCE5IIHY+j+JBXtYetqiwo/RL4O15dbTfr68ciKktha2f4RzUBo/v4BbC3dOI1t5Eyn4TT/5iDxCIaZvvuWHEVpQbi/GlI8b6NOT8lzVjxsuX+a3RxlTmLEQm2IpHP8i/I9lpV0m5+5U6u3LML6KVAHEFGHEz4F3fn0C+xAeY28YWep+wDc5yLDny2WfWaiK2rWbeS7BPos3XKf4FG/SewTUOAcx11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ba5OU5sg2Nf4gWoqjS/jo82/CH7hpIVy8hpW4XhmMk=;
 b=xcCHI7VK/Eprg75KSrFr7y4mDmd5TwYS5fewUKrUoCq+kAgraVchJ+F04+NC7xk+GDGu4sfThQBsFUIcE1RMkPddYmPYYLPPYP1JH/9pyKP3KJP7lcDGM54XD09i9LGGZ+VtpxFcwXaXHA4SF7Fx4lmXxihU13A31Je0+WEGMZs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1596.namprd12.prod.outlook.com (2603:10b6:4:d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Thu, 30 Jul 2020 07:24:56 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81%7]) with mapi id 15.20.3239.017; Thu, 30 Jul 2020
 07:24:56 +0000
Subject: Re: [PATCH 8/8] drm/amd/powerplay: add Renoir support for gpu metrics
 export
To: amd-gfx@lists.freedesktop.org
References: <20200730032839.2517-1-evan.quan@amd.com>
 <20200730032839.2517-8-evan.quan@amd.com>
 <0785697c-2455-e0e1-77fc-83a1bf125211@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <f0717a40-9ff6-2e43-2d50-311c673d9757@amd.com>
Date: Thu, 30 Jul 2020 09:27:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <0785697c-2455-e0e1-77fc-83a1bf125211@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR2001CA0042.namprd20.prod.outlook.com
 (2603:10b6:405:16::28) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.0.141] (165.204.84.11) by
 BN6PR2001CA0042.namprd20.prod.outlook.com (2603:10b6:405:16::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 07:24:55 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5808c894-33b2-4946-4749-08d83459a8ab
X-MS-TrafficTypeDiagnostic: DM5PR12MB1596:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1596A596940085B9E622B0A98B710@DM5PR12MB1596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMe2wPwWCjGNmoKGAnmBenGLXn+V1buvMbctpmwZS/3Uz+RbyvmU71vVu5aujyBnzw+13LfYC/3Fz/7Qhb50wFWPAHTYAqcWXrN0jAau2kVwllKYqajwfi8RZQhbItvjrer7Zr0cVbUViOYvAZ5vHUhdQUruGVmNlOHSiiOt6oPOladD4rayZ/JWlYxuhne1vlxGoe/oUuNoKrVzVrrdZyjDDTu6oXOGxipHr/pWI9oUIlJ+eCOzSz/f61TrTjJXg7uw1B06YKyMxO3vIF7WXpxNJ+gghrMgVWk8eDH0dWZ24VzHubYuIvkAC+bShRj44PlEAag0Up748Aff3TSh33v7FiTebyJXep/JjGTYaqkKfAQto8BQADovAqLmB1KB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(31686004)(558084003)(5660300002)(2616005)(2906002)(66476007)(36756003)(956004)(66556008)(66946007)(6916009)(53546011)(8676002)(26005)(16576012)(52116002)(316002)(8936002)(186003)(16526019)(6486002)(478600001)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sxotxt4WrYBf/dcrTeJAh3jBTmbJUUvSmDn0ykT/pKHoR3MCCLzuYQvOZWJfJzvdUnOzyRGnO+CkZooCh2rMeo597VB1+EMdj9RhfiaZhyF5OQvNh/ofNilf745hMnUvfzH7Jvxkib67TodwKpKR6lk7BOmcysSEdUENdjf4k/dFV6l/pQck5aJ/JOcJzc1Lrl6wgOOo20vFwGTzUDQvxaq/URcidvyMWOT6pCO2JpgJayuXQcH+Dh22C4ETKRQfetsQOUvK17REtcqqjFj2TyYDL1X3eWkZR/gt+nJkG88QjqxHlerAMasY1xPIn1w50FJugVcq/0Ba4CS3mkryuTe8AqvdhqpOuRBZozYt//1DXlWOl4BOx3Y4tSvrFxRUqOxfxMYN6WZQhw+FLo0SQ1geM39z467fraqlMWpwqUuG1NLrBV0wzYd92jQNsLT7xPbn5Qnph5KBkzNOS+mHFWWm+OVKbeb2C6C9xBKx4l0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5808c894-33b2-4946-4749-08d83459a8ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 07:24:56.1344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nMnfNE+VG2cNRVj49QbqwpI5QlC8Vp4i7HVAjArzNAeIwx4yHIs1VzHO41vS6lbQaWp8dm8yp8INaFK6XmhHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1596
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 7/30/20 9:26 AM, Nirmoy wrote:
> memcpy() would this much more compact. 
memcpy() would make this much more compact.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
