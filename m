Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CC2C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 12:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EB42071A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 12:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T53M4+1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EB42071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 692F572A3C;
	Fri, 24 Jan 2020 12:45:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB9F6E365
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 12:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzqi0KiF+V0KV6O1IKb/U2ZI1wcfsQKYMSmUnfOiwtwzDJCYYaQxBQmG2TCunTv1S5wnVqqBr0n7Qmrr4L1GaAzl8TTXcrVbsdWhCy+avz8luriC93eYAJi1hhkYX9Wsx4IkIESmPFpsVWF6eRzrbAPzdnGQfo3S35s3GzoQB373N9FXcyCFuxX/AZg/srNfheSXeLLWN9NQPCpebf5D3h7zy2GZXTN0Xbwn8+UWgkiaoJmnRqUK5BkiOUI1wFwW7WmacXFKfq/0KhU0Vad0ctRpJKx5oqJFpFyjd6bGbd4tM/WS1pTDuzjuYvrXWMcNKHNETYauYWsST9VitD9OMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwVqaG1sh/swtzpF3ETLXlZKa3pxL1EtWEeWGkPFEms=;
 b=TS3nTs+0VdrM9KPEn4XCsDQvFfp68cBPm9K31GUVSJPpYY64Il4uLQDEm9heAAB7RfL1G9B7Vowk9P3Ih84bLmhIaIwTa4xXCvtwxduJgFpbPK1VsY88hl+iPc1E9NJZpjt8IOmhZo64AyMe2MMhoDgYRw40R2EJi3D3AfnYQRbFy9worqN51SUfKXlZm8K1JMfAkaOjaXKoY2iZJQIPQzWZt5KvC8Als0NB6XezmreFff9mdsunabqS6LXj7bxSywbxANul6AA8wNhfFLXtplAbfWJ+QIMrHq9FRQthN9gn98Gft/0fvb2OAUnl+Qmdb4OArc/23f9FAaAqpO1htg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwVqaG1sh/swtzpF3ETLXlZKa3pxL1EtWEeWGkPFEms=;
 b=T53M4+1zEPbgWzkysphj8dDY8XVe06kNOp/esnsSHURkqrOIG9a4Is/ccbykmW9NsRPG/OUM9SmwMXShIf6dOE2h90eFz34Itqfkf8UDOtoe3CmKFSpdl4LUXw4LvEmT3UM0Yua+WCKBsv4nlU+mcj7xJn8IpTOb4O90/0ieg4Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1148.namprd12.prod.outlook.com (10.168.237.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Fri, 24 Jan 2020 12:42:06 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 12:42:06 +0000
Subject: Re: [PATCH] drm/amdgpu: allocate entities on demand
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200124115311.8037-1-nirmoy.das@amd.com>
 <bc9b30e6-1ecb-574f-8712-446091cca580@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <c62a3859-dbfb-8b5e-ec9c-4498220e3f61@amd.com>
Date: Fri, 24 Jan 2020 13:43:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <bc9b30e6-1ecb-574f-8712-446091cca580@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN4PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:403:3::16) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f2a:4600:f739:b646:7d2a:1c91]
 (2003:c5:8f2a:4600:f739:b646:7d2a:1c91) by
 BN4PR13CA0006.namprd13.prod.outlook.com (2603:10b6:403:3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.14 via Frontend Transport; Fri, 24 Jan 2020 12:42:05 +0000
X-Originating-IP: [2003:c5:8f2a:4600:f739:b646:7d2a:1c91]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9ef7031-7776-49fc-f80e-08d7a0cad21a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:|DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148B890C8F5ACA525E1AD4B8B0E0@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(66574012)(31696002)(4326008)(8676002)(36756003)(110136005)(81156014)(6666004)(2906002)(8936002)(81166006)(5660300002)(316002)(66476007)(31686004)(66556008)(66946007)(2616005)(33964004)(53546011)(6486002)(186003)(478600001)(52116002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1148;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJRdYhw1DWMyqlCULvqBwGSPMVb1srArvkeTLxkmpzHrsLORbULwsHEV3G13pVIa1AnQ6TPQ+6/dwdAF4fTiZJyoBtL0ZpSEtPshMzVGEFw7FeRw4+/A3YFUAqB37b+A1oO2wf5eRCoT2haHuvbXSRPcevng++nSvl37mvMH51Kq94pU8qDmqN3pZnAlHhIyAdDPL2un8OazFpHagD4jdF4E80TyFOM2Myet5M35QW47HDI3WNlI0LW6L/UlA/CGyqVuYEUHficcwzPLZbc8bQf8KYKxse0rcGnoCQF7rX9MMv5QQd+Whkbj5r4+nCiX+z6q7A4VcTn5wNibl84i944OPZRao3uzQKsbRXXN/YC2ArXdXWLQnr74iULbSVk3UAfJzAZCC+YOPPqWgF6BqSwn6hsyi8vh0hOQ4DcrE5rvCidHMDat5o6spPFx4DP3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ef7031-7776-49fc-f80e-08d7a0cad21a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 12:42:06.6914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKnRg5FHFuohgpMVsBmmKPzIV+3ok36Rg8i3SrelYL82o4SF7LExw5ZFrDO1LG/CnT4Dz5qsx6thozqW+P/RqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com
Content-Type: multipart/mixed; boundary="===============0566354916=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0566354916==
Content-Type: multipart/alternative;
 boundary="------------62195614AA83EC7CA416F7F8"
Content-Language: en-US

--------------62195614AA83EC7CA416F7F8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/24/20 1:09 PM, Christian König wrote:
>> + return  -ENOMEM;
>
> That's complete overkill, just statically allocate the array in the 
> amdgpu_ctx structure.
>
> The maximum instance should be 4 IIRC, so something like "struct 
> amdgpu_ctx_entity *entities[AMDGPU_HW_IP_NUM][4];" so a maximum of 288 
> bytes used.
>
> Only alternative I see would be to allocate the array behind the 
> structure, see dma_resv_list_alloc() for an example on how to do this. 
> But I don't think that this is worth it.
Resent with added

+#define AMDGPU_MAX_ENTITY_NUM 4

Regards,
Nirmoy

>
> Christian.

--------------62195614AA83EC7CA416F7F8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/24/20 1:09 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:bc9b30e6-1ecb-574f-8712-446091cca580@amd.com">
      <blockquote type="cite" style="color: #000000;">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        return&nbsp; -ENOMEM;
        <br>
      </blockquote>
      <br>
      That's complete overkill, just statically allocate the array in
      the amdgpu_ctx structure.
      <br>
      <br>
      The maximum instance should be 4 IIRC, so something like &quot;struct
      amdgpu_ctx_entity *entities[AMDGPU_HW_IP_NUM][4];&quot; so a maximum of
      288 bytes used.
      <br>
      <br>
      Only alternative I see would be to allocate the array behind the
      structure, see dma_resv_list_alloc() for an example on how to do
      this. But I don't think that this is worth it.
      <br>
    </blockquote>
    Resent with added <br>
    <pre class="moz-quote-pre" wrap="">&#43;#define AMDGPU_MAX_ENTITY_NUM 4

Regards,
Nirmoy 
</pre>
    <blockquote type="cite" cite="mid:bc9b30e6-1ecb-574f-8712-446091cca580@amd.com">
      <br>
      Christian.
      <br>
    </blockquote>
  </body>
</html>

--------------62195614AA83EC7CA416F7F8--

--===============0566354916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0566354916==--
