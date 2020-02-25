Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E2BC35E01
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 14:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FD72064A
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 14:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fFOzqEO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FD72064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCEA6EB15;
	Tue, 25 Feb 2020 14:49:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C51696EB0F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 14:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2AHk0exe91PdXt1iAEzv7HyDC8n2QdcsJF4qD/VEucWTu2v0Ms8bR2ySekBJs0Up5JBowwBNWIvfwaVlQ6zUMK+TvxRCzyO3h08YIFU/04hwIr3xxSCRcvsLckbQomAxOLKo9sg99B591ZgdTeW+EGb/tDnNTgt4rRTcg97YaNWGfvzCNkV5Ef0BcsGez7UnhbjQsY30yKcF319bHyUp3LGRrv4pOCMIVMj369zJEOrYs3cakKdVq7+PloTMtYToDBsb6mWuo4ZtE3/FKTO+aJQsgxdB9Y1X2OQ0HaaE35B4BsF58dnLITUp3DfIZQJl2U/Gv5QNIIHpbnbVop+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BffjWwlHQGQM1emqvffYCV/kZ/g3LSWjb86W6GNlVA=;
 b=K92+Ipy10suONybNpLtZhgAZJdJcoHev2k+TDoUprcDRbBmVgGrWZqE5VdJzArefGDJx66OSYQhgoExIDANvpGNuuozn0TAVvXuxx1sqETTzykS8JN9jA2kGYuNnr0fjquhuQDKb01VzzgKN5ktdzOY9QkapgGYvrnqjEBcORkoLKaJsBfCftYHXl85c8Qjx7YPAnMAY5TsoFlcIfYmDja6YniOD58JxlBov6xUySOUtH+yT972//aT9rOR0kfQrWPjm9AHH5nysnK+H+2LpE8g8qUuQ0dtAtvCIew5Cd5zQlLTE02Tab0v55f2LUvL5C/TtGfngsZ4ALi+aS4y7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BffjWwlHQGQM1emqvffYCV/kZ/g3LSWjb86W6GNlVA=;
 b=fFOzqEO3KQowcvBdnK/rHRf/NGzdk16M6cZQWTaoxnRqcB9wOr60Zco4Fjviy8/B12NmLOG9yhycOSgrDPzymbp/NPsVqOxrq1074rA/rUzBUUZy8tmL3h1enUxF7/SYJ8FCwnptMr+6tqntLj2XnFBAZGabh4sWIsmWdBMp12w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1817.namprd12.prod.outlook.com (2603:10b6:3:109::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Tue, 25 Feb 2020 14:48:59 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 14:48:59 +0000
Subject: Re: [PATCH] drm/amdgpu: stop disable the scheduler during HW fini
To: amd-gfx@lists.freedesktop.org
References: <20200225130736.2929-1-christian.koenig@amd.com>
 <87b1face-f3c9-ca0e-5ce6-9b96088ab4e7@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <53fc93f9-77ff-9185-b00f-fe2925bd9553@amd.com>
Date: Tue, 25 Feb 2020 15:52:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <87b1face-f3c9-ca0e-5ce6-9b96088ab4e7@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0009.eurprd05.prod.outlook.com
 (2603:10a6:208:55::22) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2c:dd00:254c:e011:75f7:66e4]
 (2003:c5:8f2c:dd00:254c:e011:75f7:66e4) by
 AM0PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:208:55::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 14:48:58 +0000
X-Originating-IP: [2003:c5:8f2c:dd00:254c:e011:75f7:66e4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 038318ee-8e21-43da-dc0d-08d7ba01d8cf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1817:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18177735A0D99F72A0BDD18F8BED0@DM5PR12MB1817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(81166006)(66476007)(66556008)(36756003)(66946007)(8936002)(81156014)(6486002)(558084003)(186003)(2616005)(8676002)(6916009)(16526019)(6666004)(53546011)(31686004)(5660300002)(478600001)(316002)(2906002)(52116002)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1817;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhr1LLVYSdEviiNm/U1rX/zo+YUR9EYR9lykkKlzhGhaMF43ZIONuBZVtCnTGVgCaaTUSTsMptfL8zIt821i4OolOO2nF4ZpTq70CBdiFTbg2SqpbiFKKJYIL3A1uZC/ghghoaq8r9jaYDHBI7V26NH5tYdQtaj8PeGnLL/Rmn3H1dvTvjuU/+AfYVdKUcteE/xHRYsOOwWbhsDm+PLGKwC+WM26vlN5x1LXZ1Ep0TLwDyCblbfz3NYa1K61RbNMaKnN19huhojgBn0zv4i7DyuQCIMCuRNVJ6peTQDHTeusVKPGdqHUcAAiG2pRxoxtze6cAKI2Yv6OOFE5BZiLkIJ+mz0iv/gTlsbOfE1J95+WQpOdGah2R0RIk9pL0Gl/n/zExYAyDcMsluxmw3F3inP+Twpd9JNZrEvxaPQ9rn6VDV++JDUnGEESJN/+Qy4u
X-MS-Exchange-AntiSpam-MessageData: +TVV5EEHwJj0GlkX1JvPxgLtV1c34129xXNuGSAmOnPXn2/wKNuyhCtlAZKXiaslIS8DE0ZahTpZut6EHkOnk35FRWciLcvErD6/seVdjFP0eQNUVaRbpD3g88R6BdCJzjCOFS7fhjnCppF3ihWd6JzLaboYU3g+DDVC9Hrr9BExfgP2m1kq0EZN4KizruyV7Es6XgiSlDdTuGhaX3iQgA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038318ee-8e21-43da-dc0d-08d7ba01d8cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 14:48:59.2408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OskPbnMo205iqiUwP+zX7/T6fO/hGQAXl0V5NRGu0rpfGvmBP+XQS+X78Iq5sdeavgvHINtHVfP6k38GH/fgTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1817
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


On 2/25/20 2:16 PM, Nirmoy wrote:
> Acked-by: Nirmoy Das <nirmoy.das@amd.com>
Please change that to Tested-by: Nirmoy Das <nirmoy.das@amd.com>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
