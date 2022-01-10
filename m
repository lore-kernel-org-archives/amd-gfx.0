Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E338C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 21:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 272FD10EA5B;
	Mon, 10 Jan 2022 21:19:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27BDD10E4B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 21:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH+UoDHZWamiyxE32/V+3T835vK894S8d8TKdS7WOwzaH9HEPf2BNVa3BW2a+9eGvRkskPp+THOzg9MBXsqtxKVDODnjrAjNnmDo1wxtGQOQdUHF2n1WVsbSnJ0AV9lTOyi1moUKkL4EGjwEWmAkChyAYzmRo1gnGflp/qdMfWTaklakSBtq6ZJn0z+SM/mpgwJwqJuSsgdQF5xrALI4P3V17WkBcbkEF1OT2aUbw8KIS8dOEJPc+qPzB1VXCfmrPUXzdjBdHAjRpJiDV0O8ispFAvz3kbVv60rxQ+679u/UOw+ic3MrsYV+QAHCAWTRmGTpGbNUbS0BQIfby9D0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW949RdD+wKTj1/XyvZ7qPIZU2pejhp54zkgcDZRWvc=;
 b=TmQP9ccj1o3MCoqMc2WZ/95/JD2ZaknR8cdMJtgzoOmwzNVEjpOcjg2tOgIMP57oAatYMRxBz35kYi+7h4Hv8S8bVUE2HRufeUKx6M6pYDdDhLOC6HNKrqWAq7PM/DjZU+qcf2CbBJGot05rOS8onfVygqbWInWB3jkLmBIz4kP+00+D/h4UJGaG6BokkUKv84EjvbKpz03idXR1oH+lng5958vzDuxXcMz6PFUT7Xjvgr5aMck51FyuuABikUOokajTwAaSaPnhRS1WWqUMn5bqDoYJiOK+jNpbz54JJ0A2/oTzzjuuCOEbMBw0lze1SY3MJbwTh2kKw7GQKhChZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW949RdD+wKTj1/XyvZ7qPIZU2pejhp54zkgcDZRWvc=;
 b=rZCEdlAoo1cAwR57x7TXrRC+5HXBEpjJiv4cBUBj4kGeEGCCJ2vQ8N5plY8Tiw2xWnU9gZ91K9L3OSGK/kCLJgvgR/2ASmOs0/IMjKhPLoEwi03RcGYRMO/sdF8XT4k4xX2o2CnkMZo5KINXRIdpG2GozBpHZ98gHdnle2t8CcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3180.namprd12.prod.outlook.com (2603:10b6:5:182::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 21:19:50 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::f452:e803:893f:2fca]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::f452:e803:893f:2fca%5]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 21:19:50 +0000
Message-ID: <ee1e2d9b-5443-7539-7cae-7ceb47dda8a5@amd.com>
Date: Mon, 10 Jan 2022 16:19:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] drm/amdgpu: Fix unused variable warning
Content-Language: en-CA
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220110203255.95468-1-luben.tuikov@amd.com>
 <BL1PR12MB5144285CC0A72A1FED2B3936F7509@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <BL1PR12MB5144285CC0A72A1FED2B3936F7509@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::49) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ba930a5-d05e-4451-614b-08d9d47eefa3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3180:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3180585D0AA779CAA22A02A999509@DM6PR12MB3180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:234;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZc7OzmGoJoUbKTLL+z8LbU27Lww+TpPvZ4uqowuzW0oarDRIdR2Nq13+GBE/gYq1Mt1w3xE6s/xoc6cUETVY8nANROcNZOyK4hUtStFCC0oqhl66oN4ZAPSOlkwZYJ/+cYnrHXztfvvjYoivnbq9D0Vifks79/Drpwo7ZV5823DVbGUT+XC/joF+O8Qth8UziKEq1qmkyVBe7C4tWqW79SoqF0UjGckG0uKixgQv4bxX2Bs1KwHbG0wpixqvgRAbJBHuKsZXeceGowhvZw0lnOrHXb1DfPqMD/OkWOK7VQOOk6sfiv7AuMEX5bCbfUAzDbV3I7SE38ZSHl8C52EILy+aJFria2a1xT1aCBQdeC4zVe+qXTO6xXVKBUD/Rdp5HaxRUwTE5D0Z6km1EKd1MMwLn3BCgkeE1LclCXsctXoZNPH+CMAHA7dT4KVq4o8ffTBzTclmvyXec4YV4J7/AKd9Yq2r7KA3Nmj91iwLAY3HWVDHO6MfrqZouiYZt2VyCZbLns2i3NdLOY4tP3wnCk5pSrafp3yIBoPFgztcQo21uPAZjd0r2zim3UobjiBl6r0QXER9atTM7cRPAJmnQkkR1saKGYeEukE2x7BCPuk2yL1mM9gwL4E9d1Ogymw2p173nh4ABey+fwRWNTVJGOM5HtuVJqkNo+4QIvXPD0nO/b8z6armgPDKy2XcGKyzFbk4cv+B5FfTaNsSAo9g6WB9btRRQQIUL5NqOhsWCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(508600001)(8936002)(5660300002)(2616005)(66946007)(2906002)(66476007)(66556008)(53546011)(6506007)(86362001)(19627405001)(31686004)(31696002)(8676002)(6512007)(36756003)(83380400001)(4326008)(186003)(316002)(44832011)(26005)(6666004)(38100700002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHBsYVlQYW9yK1NtYXpmOVhhZ21VNTRRY254UEZ4Nmw5MWRYMzhFdjY2NWhr?=
 =?utf-8?B?RnE5UFlRbFZVM2xhVnNUUjA4R3Zkc0VXWmFneGt1M2w2d2VpK0FodEhSUmds?=
 =?utf-8?B?VGcvYjM0WElaclg2ZkEwTVVyWWRtZFkxMCtkc1pMTEhDblpYZjBWRlpnYXBi?=
 =?utf-8?B?Z1VpYTR5bmcwRDY3TmFKbndLRkVUaE9KeS9qcGF3Z0gvTUd4cStCOXFTUlBn?=
 =?utf-8?B?ZnRQYlU3TXdVVU9saG9CVTR5K2lQNGh3Mm53OWRLVS9TMlkzVldUVDEvL1l4?=
 =?utf-8?B?dFpoN3ZpVTdDcnVEanl3K1ZFaVQrL21UMlRBNis1aW1QWHhxOFZvdTQrcDBP?=
 =?utf-8?B?cHRsZi9TbVgwUll0QnZmclJWT3U1MzFHTjlrNGNQNjVoQmp3eG04RjNjUGVR?=
 =?utf-8?B?YVhYZE9HNWp1N0ZSYlhmeXd0akFzZmloczJDbGpIbXhXdzlqeldxbWRzS1dn?=
 =?utf-8?B?ZDNWcisvMko5Vkd4NjdrdXMwU2NDcXZEYjYwTmtDUzdSbG5XYk5kN1EybHVB?=
 =?utf-8?B?cmlYUGlqSXcvb1VFRXBPWS9OUURjQTdITWswUjVXUjVnc2FKYWEzQ1lxZnlE?=
 =?utf-8?B?RUxsbmF0TExsUEVSMEFoeVE5U0VPV0tKZkxsU29FQ0pxKytqNlYrajI2aldD?=
 =?utf-8?B?VGN3UDNlYWd4SGdPZVJ3OXZJWEM0cmVNN0ZHaW9IQktNM1ZTQlg5ZFZoUy80?=
 =?utf-8?B?T2pNTmVDbWRlSmpOTTZIdGdzSmtrTW9VR2dHZUFNS2huOVRBZTRvaTNrVmJy?=
 =?utf-8?B?dnc4TlNOa20vK05pRFgvU3k0OG9yUlcrRlJERUVMSkxuVkxCWWVKUzhIellZ?=
 =?utf-8?B?aHdCSENneUpmb3U1RU1DU0tlbkNtdlZuSXNwb3FDV0xNOFBmSXpjczhWRHVN?=
 =?utf-8?B?Vm1mNklNalZXVFhpKzc5YnRZS2VGUkQ3UDZLNGpmc1N5dVZWbGIvREU1TnNt?=
 =?utf-8?B?R2RXMU52RkIvV3o0WldMRERGYVVhY1BWY2IvdU5Bd0lhQ3IxbHZnc0ZDbEU0?=
 =?utf-8?B?dVJVOFRPUDIxblhvTE80blJMM3JjME5DSEVHcVIwUm5RTEQvR1JuaURsYVNM?=
 =?utf-8?B?b2NIanNpZ2FsdHUwcWdTdVN3eTNZaWdkS2xWc080QW9pWUFaTVpiRDNEMjkx?=
 =?utf-8?B?cUFFSlBjY09ybW1xaHRGbk5DcCtIWFY0QnV6b3I5ZDExNVJMSDRmNUN0dFd6?=
 =?utf-8?B?SlI5MFQrWW9sTDlueWNocUxlcHJyaGUxSlBIa1ZNQkZMUjRJcEwrRlU2bTN5?=
 =?utf-8?B?Q1dPQlNQcnVTb1dJRkJOQjk3UXk1OVhwTXh5L0Q3TDNWZHIvWDZqaHBUYnR0?=
 =?utf-8?B?UEFic0dkSGdOcFlsSmVzZUpCWWZiM0ErUFpHbUxwejVTOENFVE5sRFRVcmpO?=
 =?utf-8?B?ZDgwLzJFQlNzS1hkcEhYY3J2UDU2L0h3a3ZmNWNVQWhhNU5FbkppOVdzbUZn?=
 =?utf-8?B?V1VsZ24yTHYzZmMvQzlwTmZxOFZPVE15Zjh2Q3hvMEZ3UXJpU1p6Nk9XOFVv?=
 =?utf-8?B?OCt6VzBYODNFNGU1Wlc4OGZmZnJUVzZzcytZTjBoQ2xjdGVwYlFUY3FIMVdi?=
 =?utf-8?B?T21IQXZabkFUMmlBOXNQbW4wNUhvSzJFNFEyOFFoV2VydnVqbGt1TjFlNGVw?=
 =?utf-8?B?b0dDUm9vLy9rTE93K2k5SGx4anJ5VDV6a1BvNmtmQjRFcVdRNEVVa01EVy95?=
 =?utf-8?B?RVBWb1gyOEg2TjNtTnBWR3FKcmZsSTJRaXA4c2ZFYTRjeVVQQ2F4N1lVVmVZ?=
 =?utf-8?B?VzFlY3dmMzVDWHpmQUhzUGFkN0V5VHRDZFRoVFBTUHB6TEJpSFZRbUQzdW9W?=
 =?utf-8?B?eGxsV3ltcHJrQXFjYTVvLzBKOWN4eHdVVFV3cFZGY3E2K0UxNExrSEVaT2Vp?=
 =?utf-8?B?TWdzUXplbndoakhwcmRPSGZHMUI0a3RuTVFzQndrQ1BkWm5ZVG9YVTRTZzNJ?=
 =?utf-8?B?bW4zK3VSeUFqRm90UnVjYVBYMERPNFhaM0FtbVQxR1lwRW53bnN3WWRtSVQz?=
 =?utf-8?B?eFVodEd0NGJaN2lodWVsSEtOeHMzNFE4RDRiUmFOUGJiL014ZS9NeVBTZlcx?=
 =?utf-8?B?RjB2TjlZQXpzRDhDa2N4ZnZVVHFxeFFWTkJXMW02WlJnbFBqS1V5cC9LakFJ?=
 =?utf-8?Q?9b48=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba930a5-d05e-4451-614b-08d9d47eefa3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 21:19:50.3252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epsOBh22qMmFHn50I6INjFsAkYB4VPY2e0azzKD8770KQDX6sGHBVG23BgTG7dWs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3180
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Okay, no problem.<br>
      I was actually wondering whether to add it, since it wasn't a
      technical failure...<br>
      <br>
      Regards,<br>
      Luben<br>
      <br>
      On 2022-01-10 15:49, Deucher, Alexander wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB5144285CC0A72A1FED2B3936F7509@BL1PR12MB5144.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Please add:</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <font size="2"><span style="font-size:11pt">Fixes:
              36324c09d848 (&quot;drm/amdgpu: Modify sdma block to fit for
              the unified ras block data and ops&quot;)</span></font></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          With that,</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Reviewed-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Tuikov, Luben <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a><br>
            <b>Sent:</b> Monday, January 10, 2022 3:32 PM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Tuikov, Luben <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>;
            Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH] drm/amdgpu: Fix unused variable
            warning</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">Fix this:<br>
                <br>
                drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: In function
                ‘amdgpu_ras_query_error_status’:<br>
                drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:945:6: warning:
                unused variable ‘i’ [-Wunused-variable]<br>
                &nbsp; 945 |&nbsp; int i;<br>
                <br>
                Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                Cc: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                Signed-off-by: Luben Tuikov <a class="moz-txt-link-rfc2396E" href="mailto:luben.tuikov@amd.com">&lt;luben.tuikov@amd.com&gt;</a><br>
                ---<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 -<br>
                &nbsp;1 file changed, 1 deletion(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
                index b1bedfd4febc4b..517650d286a722 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
                @@ -942,7 +942,6 @@ int
                amdgpu_ras_query_error_status(struct amdgpu_device
                *adev,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras_block_object* block_obj =
                NULL;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_manager *obj =
                amdgpu_ras_find_obj(adev, &amp;info-&gt;head);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data err_data = {0, 0, 0, NULL};<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!obj)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
                <br>
                base-commit: 9b7d59707fe1ff51cdfa0a048629446ff3945bfd<br>
                -- <br>
                2.34.0<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>
