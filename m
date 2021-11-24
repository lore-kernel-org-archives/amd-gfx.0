Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CBEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 22:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 925BA6E17A;
	Wed, 24 Nov 2021 22:52:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F4906E17A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 22:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrMdxZ9KnevR4i867yQCQ9EQSdIOEFK+kcIak5SHlb9IGN9vsnoOrN0djdOneNIc7Oxe6kKfWkzggMVjWsGkYKEddj5bABY31YVxRejJbtr5ueoChiEyXKTXiKGMt0gIc+8hk2KDvi7HA4y+JlyHGguqsSP8acCyVaK8dZx+FNZDt5Z+3ZiNsiowbjag+cbMnbOlcfQEgfraEn0fvqVpBWStNc6FrSExodcDYlNSPDeo2YjUA4ZaIHZhstDsR0YBi0In8C6MjQ80cNbi2ubs5t7oAviYj9eaKJSNA0fBMXiFLniEPfiIksajMePDeQzdH8HK8eIXgMyoNtrVioTw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmq/EN2XHB46LQUeDZUdlII7QEQj7fdYnS86g8x+TMo=;
 b=NO+spo+7k12ih1I6FSDp6FTQUNpJiS0s9dLx+EJoxHyjluKEcyAuhlkiybjWiPeujHpPD5dJGnbcniDBBe2FgJbqQtme5Z7pc1CZtwxAkYMJDTVP9umMKE/b4fFvrH/iG4gFPLCw+bF/QSMI1Wl9MZwKrEQVKDPIMEfADOtdPtWzZm1wcsH7Kk9bbsGOzprGObuc/V0WbvBjd2EHK8LaYqsm77v2qGx/m4ly3RCxshz5wBtjK6pm5vqSBfFM4OhO2IB/baYy5ehfMH0w2KsfKQXL7ESUetPJaPljno1Vnrejjy1epyfYln639WdbmLSf2roH+gUFJIq7LWHKVPV1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmq/EN2XHB46LQUeDZUdlII7QEQj7fdYnS86g8x+TMo=;
 b=c05bGlnT1XKg21u4UB2CsnzakYf8cptkfyBP1cvubZQNs4XCjNk3HUgq8yFciWYRXVjoG3dGAD1k+lxNHFR0nq0dT3K07dfgHwc9ozEioQNLuMZYvwsqaYKLcv7QYkgiMDchUfEFWn3EfLBd7BJ4q35o6ufmm+odk7DEkIl2LuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Wed, 24 Nov
 2021 22:52:03 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4713.026; Wed, 24 Nov 2021
 22:52:03 +0000
Subject: Re: [PATCH v5] drm/amdgpu: handle IH ring1 overflow
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211123192254.21681-1-Philip.Yang@amd.com>
 <3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com>
 <5ec42928-995f-04c6-c7c8-3d2e33744457@amd.com>
 <bc4b8eb7-698f-a522-ef33-6d2232612167@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <430de254-8f6b-3a8b-1796-3d664f1b3dbc@amd.com>
Date: Wed, 24 Nov 2021 17:52:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <bc4b8eb7-698f-a522-ef33-6d2232612167@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Wed, 24 Nov 2021 22:52:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18de3221-411f-408e-a200-08d9af9d0843
X-MS-TrafficTypeDiagnostic: DM4PR12MB5071:
X-Microsoft-Antispam-PRVS: <DM4PR12MB507110873C0E71B14A95CB70E6619@DM4PR12MB5071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2I5CiWt7Nq1YNTV8psgv/uDSsrFBk0iSuxLOa1NNgEOGSG386gy3KZuf2C33mJHlbs8hokVCtng+Ppky4E4evcpcMJRTK/Ldw33J34eOGRM0WzCm3JsFYq0rORKm41LcSA8J9OuYTiTP3YOBnDSQ3+9U2JQXt9FE6//EyMeu6vEf+651uecBy8U2RmyWmDlgCUTLoJdAyRUkHJ7n3H6SpnaUIFhiDoiTV6oI53a42IVvM0A/X1a93ul9ktqxIAy+7YpF4CpyCCfLC7adIZwas0CWdeh9IH5YKOlJ6yD5viRciNVtgR8husnWpWQBGsnJmkINRMX1tTupf/ozJSn96drZUK+NPK9ZolPa8onO/GlWw+4EBPbCuuZ44X53qCs4X0zXzI6FqtGJQhXyAuT4CLwJYGPxKwlCo1q7ljW58/bwEPVNMCxSWQd48ETRTB2zkKw0oz+nX2Md1rVwamu529wMIX2LkHQpUNFMTEoUOff7rPz1Zq4suUGgKBGbZ2Y6mLTU7sp+/sVUNK9+Ly3dSfn/PqNo4VcodtfhIjP4dtsJjgqH8waE6/URgjNfBsmnDDhbFPNK/vxNvzA+SstXzYiBtMTdtoeUuXzv9CPdeOAMAYk5oKGb2ReV8ZtTSbFhWwhBT1yXUsctudm/amcvVQhhxcZWjUS0Qe3BYT5x7AlRqc0t2+pZatqzQuufUIXOg4WXCKIQfEL4ckf/IDtHMx2kadbTwN91qRyTNFomMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(66946007)(5660300002)(4326008)(2616005)(53546011)(83380400001)(956004)(8936002)(66556008)(66476007)(8676002)(26005)(186003)(4001150100001)(2906002)(38100700002)(110136005)(16576012)(316002)(31686004)(6486002)(31696002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emwyU3JSSU94QWIyRTc0eWliODVSbVM2aUpZbEN1YmkxTVFZMnhvRTc0UHNk?=
 =?utf-8?B?aEV6NlpnOG4vcG1SajJYWW1CaEhyaDN4a0U3dWFBSDFlZUF2ZVFvSnZKenpH?=
 =?utf-8?B?TzY1ek9qeUVpWHIzdGRmOVdhL2EvMjQwWCtOUW9pTVJ5dFNldWdIMERkT3Qw?=
 =?utf-8?B?TzhOQXVyNXJ2di9pcTBYZXFRbFZjaWdWUkltWGs4U3E3UE5sQXcwMXZocitJ?=
 =?utf-8?B?UVVEYzZabTdGcWZFM1dRWEh2Q2thRk1tZHdjM3hDME05V3p6eWxBcFBNbUlq?=
 =?utf-8?B?VVBYKzBubmFZT1V0dS90SGJsNnNXOCtjeDdTMy9PcTlwM2JleVhObDhzRkQ0?=
 =?utf-8?B?NThCT1ZGTjNQSzBNNjBSSFZCK0lnTnhCTHBnL1EzRXcwajN4R3JWa1RJUGln?=
 =?utf-8?B?cUF5MElaVnc5bXlnYTdVNDNIcjQwVkxlZGNBYkc0Y3BXL3UvQXlaTnhQczRq?=
 =?utf-8?B?ZFo0MXNyQStza1lKSW1qeVJtWU41akZ2TDNFYnVaQWI0eHROWFpoYS8wV3Rx?=
 =?utf-8?B?eVJGME1HQWJBT0ZjaktOSkhaMnNTLzkzZ1crSGpYU1JKbXhwZ3pyVUVQaFpt?=
 =?utf-8?B?cWgwbFh5VkdkYVRaMjR4cXUxSHZYOXYzYktTNzd5U1YxOWV6UUR5TGhhdllu?=
 =?utf-8?B?Vk1uZ0pvVHI4U3E5K0hBZjFKNllOaWZHR21KbEIzZ1Fqa0xxSTZIOVhFV3J3?=
 =?utf-8?B?QU5qRFJYYmdiZWlZRWE0NjVIS3J3WnhPYk0vcFowZzcyVjRqb0ViZlFLdmhu?=
 =?utf-8?B?RzdJU1c0ZGlObWZhZ1lNdVUvaUQ3M0lsY1pjRktpM21IUVV1M3d4V3lkWkRt?=
 =?utf-8?B?dUlkRkY3bWIrREN6TER2SGdOY2MyWlRQd1g5SDZTc3p0ZktxcTlHNU1xVkxl?=
 =?utf-8?B?NnNodFdTRDBRWGE5SlVXNnRUWm9IYjhFWU5uc25jQnErRDJaYVh4cnE5Y0Jy?=
 =?utf-8?B?MFB4NldrZ1pjMWJ4Y2lqTzBLc25adkFYWGVJS0FNdEdBeEtaUUFibk1SNzFw?=
 =?utf-8?B?Mi9OckJwcHZHZTJEVFNvdENPNWdVYzVmc0gxTDZMV1RwL25YM29YTVdrdUhV?=
 =?utf-8?B?RndMTTJsOFpDa2RpdGExY09uTmllYWFZWEtMOE8xNGRoVHl4ejQ0Ty81bndj?=
 =?utf-8?B?M2hPaisvQ3lxRCtvS0RnZUh5TUJ4NFp6WmJzeC9uY3djZXRnZnZFTlp5T0FX?=
 =?utf-8?B?UVNDa3FEcDFPNXJWanFVcnVqWTBsSlhQY3BUdzNuMW0xV1VzWnd3c3YyN1pF?=
 =?utf-8?B?QzdxZnRyYjcvWWZ3VHNNb000cG00M09DWEdldWYzc3k1SmJSR1dWQjVZbTdk?=
 =?utf-8?B?VVNZalFpV1pJRnAwYXlMUUIzVmI5aUtpVWFGMCtsbk9hMzh6YTVlU1RHUVFZ?=
 =?utf-8?B?OERISEpBOG4rbUVjOFd1dTZkbnVzc1JpcmhQK3FXcHk5RkpOdWtSUklFRG8x?=
 =?utf-8?B?VDd3aFFEZnFrQjVhUlRSaEZIa1JUd0F5ZXR6RDlXVTdDVFMrMFNRSHloTHpP?=
 =?utf-8?B?dGVSVUlNWElHY0VYUG0rencwTVJGQmJkMXl6a1k4a0VKeWM0V0Z5MVhMM2ll?=
 =?utf-8?B?WFYxQnJmMndwK2VZa2djT09sNERaVlp5LzZhSDgyTGRFZXd3djgzcC9yQVlZ?=
 =?utf-8?B?LzQxeGZsaXdVcGgrbmpJRWgxTXlwcEtpb3JOd3JYdGFYdk9PZHBJMWp2Vy9v?=
 =?utf-8?B?Y043QlU2Sks5a3lvWmhLZWg2VXg4MW1iV3hEMWplVHpnK252ME1OTWJpS2l5?=
 =?utf-8?B?WTlWKzJaQzdRNHM4U3NZb3lWV3NpbXB2OWMvVUVuaExEdFZYaG9Ud2puOFhX?=
 =?utf-8?B?RTh5a0duMHNPM1VmMXd6ZG11MC9UbjNwb3dPRE5BNS9EaVlMaWFFaUN1dlRF?=
 =?utf-8?B?ckpiUXVXZFdHeTRnQllXQ3FWNjBoQzFUSFBJdHJ1TGM5cURTSS9LY3V4ZEhQ?=
 =?utf-8?B?dU9YUVlsKzA1L2V4SlJHRHp3aGFpSVowSkluRHN1U3BSWmZrUE1JUGt2Z1Z4?=
 =?utf-8?B?UXZpL3ZKVUFMTXdUSlRxNXh3RjFRSkY5YTdleHNwbmtLSnU5Zkozbmg5ekht?=
 =?utf-8?B?N2pyUm52aUZlcmxMeWVmL3h2WjJTR1c1ZFdyM1h6R2pMNXdvKzg2SUdrQ2E4?=
 =?utf-8?Q?k+dQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18de3221-411f-408e-a200-08d9af9d0843
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 22:52:03.5979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBzzgH3y7N8I1hgfZ68hQtiZdfkh08ztRrP65ZKLpFXUv6P8A3q30yy7nmauBgb1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-24 10:33 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:bc4b8eb7-698f-a522-ef33-6d2232612167@amd.com">
      <br>
      <br>
      Am 24.11.21 um 16:23 schrieb philip yang:
      <br>
      <blockquote type="cite">[SNIP]
        <br>
        <blockquote type="cite">
          <blockquote type="cite">&nbsp; +/**
            <br>
            + * amdgpu_ih_process1 - interrupt handler work for IH ring1
            <br>
            + *
            <br>
            + * @adev: amdgpu_device pointer
            <br>
            + * @ih: ih ring to process
            <br>
            + *
            <br>
            + * Interrupt handler of IH ring1, walk the IH ring1.
            <br>
            + * Returns irq process return code.
            <br>
            + */
            <br>
            +int amdgpu_ih_process1(struct amdgpu_device *adev, struct
            amdgpu_ih_ring *ih)
            <br>
          </blockquote>
          <br>
          I don't think we need this new function any more.
          <br>
          <br>
          The check if the timestamp goes backwards can now be done
          inside the page fault handler.
          <br>
        </blockquote>
        Do you mean to merge this into the original ring0 interrupt
        handler? Then we need add parameter (ih-&gt;overflow_enabled)
        and process two different cases in ring0 interrupt handler, I
        think that is not good to maintain later so I want to separate
        them.
        <br>
      </blockquote>
      <br>
      What I mean is you don't need any different handling any more if
      we use the timestamp anyway.
      <br>
      <br>
      Just keep the last processed timestamp in the page fault code and
      ignore faults when it starts to go backwards.
      <br>
      <br>
      If IVs should be dropped or processed as much as possible is
      depending on quite a bunch of things and should probably not be
      handled in the IH code in general.
      <br>
    </blockquote>
    <p>Use ih-&gt;processed_timestamp updated in decode_iv, for both
      checkpoint process and page fault handler to drop stale fault.</p>
    <p>interrupt handler don't need change.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:bc4b8eb7-698f-a522-ef33-6d2232612167@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
    </blockquote>
  </body>
</html>
