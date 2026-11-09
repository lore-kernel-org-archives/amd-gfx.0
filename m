Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE6F606A326
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PKa3Qayi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A37D10E1D3;
	Mon,  9 Nov 2026 21:13:53 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80FF10E1D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 21:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7wFFp0Y4ZdpeSxIe/jpni0BNhN97VTnelYbLotJ6ecN6syyGHt+HwflACWvBWNMtK3GVE/nEx5P3DDPoiD5hyugbsc3fbFwC1BcmuWhnX1XFM561hmd+VuijNtfU8ModQdlYZcm7JuRgWJV35srM7uMlgG+A20+bAl/XBjrWiXzk02rGMORJjZ/hNl/bki5HPuDkS0bgxeu6Wl1AK0CYj2pHKvlcCs6AOdUsiF72Y8u3bMgRC94lQkcfD9N4oO0cRw1gro+6MleRGzypjloijVgUedA7RpEq1zgX+xW86fbMzbVqiNMQmc+x00gf2G8JLd1g4YDmLHzZGao/a0IHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIVYrhNvKo0D8selNRtI1kOLXcmuuRqUbqiCsnHQ3ag=;
 b=UP5cBPar1++gDsI2E2vZC7ca+jpglQJTHPjGHa8iUe1b17XaYUSWLE9slWk+bOms8wHbPVWobNPQVL7PHHhg7ZlQCWgjfGED2u2oxMKhQCIDVghevxRx5qHyjmw4bfp2v8tRi92MbIallJ4ns3xvQLRueQt8s84pU4uqF7SkaiQ427+l9iOFVyQ0TzjdaNZgoG1tONhOtOJ9hiqRtHmHY0hTsst+E3rHE1tGfaAr3peS8rXVuXzHz90x/dScjX6NKDFdvkIzzKeof98ItU4XzH33a+nlB3z6+gnVPCcvZkrSzWyPQvx1TNyr/Ph3nXpEjUUGgIf5toTwxoKpS6PJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIVYrhNvKo0D8selNRtI1kOLXcmuuRqUbqiCsnHQ3ag=;
 b=PKa3QayiE/IdQIpdATJ1AXYbmzXZm8Y8Aak9RQm2DMmzLJwIhEfGblOYgwUO/MOc2LgDFbp60UYSgZau2aqiDxyrXNhlVGP0rpGHC+ypHD/5qE25To+vFkEYdCpHoqIGkl3EvSImt5kitmPPOcVt44v5GSP2fChvpSKsHMbdIJU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by BN7PPF9E4583E15.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 21:13:39 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 21:13:38 +0000
Content-Type: multipart/alternative;
 boundary="------------ktrWYMYoANa0X0wYJMxX0Mx0"
Message-ID: <1f723277-803b-484d-90b2-af500ab98496@amd.com>
Date: Mon, 9 Nov 2026 16:13:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: code review for kfd bug fix
To: "Han, Qiang" <Qiang.Han@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 "Gandham, Shashidhar" <Shashidhar.Gandham@amd.com>
References: <CY8PR12MB7337BDE050C52DE73659883AE4732@CY8PR12MB7337.namprd12.prod.outlook.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <CY8PR12MB7337BDE050C52DE73659883AE4732@CY8PR12MB7337.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0304.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::20) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f43bc3-33eb-4f9e-0fd8-08df3ea652a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|5023799004|261021121427099003|261009223027099003|261022105027099003|56012099006|261026140227099003|261026121527099003|261102123227099003|261028144727099003|18002099003|22082099003|10067099003|8096899003;
X-Microsoft-Antispam-Message-Info: 27ehpC0SnCEf/oRSwuIkRRmwc7ImHARqPCsYtvhXIEFJJBYzKj3uiDsvczMIBwpBrM5mum1o8GzsM7JrMCioaiELaAJlj1fpFKrfRBqkq8qpUp0lOdhsSBCVCfUS4V9oGLWfHqkcsd4NOZGcaV/m2Yu0YeousOaq9lVxeZcK3jvtLejkNHx5L4YzkWjwgtx2QXHzuj6Yia0QqVhrbaBTALgk1x9g+WgZ6Z+Gi8Aga7TlzAuTpTNm9UHGINQf4ovnqlLaNzdzC2CVctoFcpM1JtY0lVFhkrZERKM83dVGhjyYDZtvQsXIWkJd83mHDNFyNRAjG6lpMDk1kQvMbtFE+JsqeIX3HMZ/atInA+0NHOpytOwMVEGM38qQgZGLs6uHuri3deZddB5pY+QvBS6DK1bBcx9MuP0bZG/VzX/yvDGJwBe+X1cYS7cRNZ4NkdR3SzeF0j2O0QoQBk8zQMPaB59GrwL32BTFaSdOKwmGQuFhq+l6dpPC2Dhm24PLBtnbknSGZX0FPghceV4l7GwSAjguVB0b8QUmXMWq0ZBpUsVqEfgpTrDlLD0U/B3I/fM+F8hh62XyZ2Dgvjex5c55voatjc2N475pcxh9NUPxIvMCJG8hMD3emr3XaDSb+h54ZCjxjCt2b+gbU6blxaREXago6gslt35mYPu3ng/JwH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(5023799004)(261021121427099003)(261009223027099003)(261022105027099003)(56012099006)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(10067099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUFaQkFIT1p4d1VUdmlsUzZIS0dUU1VheXdFS3VCZ2pOQXNUSmFiWGFRY0Ft?=
 =?utf-8?B?UEtMWGNZTnNFbVhsemdraGhweEI1aitLa3ZiYUdpN2NoVnJncnJXRWdnSklv?=
 =?utf-8?B?Rm9zcWVOUC9VWEtMMzBGT05ocHZNRGtha2gxRHdYN1ZhODg2ZFZRN1d0UGxh?=
 =?utf-8?B?elRFN2gzeGJPQ0FYWTI2VkRxYjIzcGcxQnBFSEt4NTNZL1ltcnFDU2UrVERm?=
 =?utf-8?B?WUFVMlhSOFhpeVlpZXowdzBHOHNkYkQvMS8rajZDTzlQSlBBSzlYRHNDVmVm?=
 =?utf-8?B?dHJCYm1rTVloWXpNbGxDWFJOTEEvdkNFZ2I5NEE5MUFFaURNbUlJTHVYTmZO?=
 =?utf-8?B?QkwxVm5scnNMS3AwK08reld5WG1ZWUJZa2NEV3dyWCttU2s4YzVDTi9LeGQ2?=
 =?utf-8?B?TjlpbjAzT2Jnc0hzSzhSTWExWDV0ZFQ3U245TUFIdVJ5UHpGLzBiQzRFbFdC?=
 =?utf-8?B?V1RYaW1xRzhmMkt6aGpjNUFEYTZVZmhOMkVCOHBpL3Z3cWxmOTJKZzFBNURj?=
 =?utf-8?B?amZDT0hHL3pyMkZ6b25vakhxWFRqdDZKeUVXaHZOVGV2UnZaZmJXZVBNdmtl?=
 =?utf-8?B?dkVPWTdLWTBSaVFESWVZT3dXSldWVWJDOTRrU3Y2djRmSkVXSVZiOXgydng0?=
 =?utf-8?B?SmlkUnlqbEVtR1N6SVJjb2NrMFBVZ3hPdEQyYnprUHFLYWdMUnNSNlhHQjh0?=
 =?utf-8?B?TnZxdzdJVHdUU2F3c0FzOGQ1cFFacHNyTHRBbER6bENyUDgwZzgrYjRFUHZi?=
 =?utf-8?B?Wk03VmR3ODZ1UDlLREYxbmJNWXF1VXNCbjY5SVFUMXJVb01KSFUxRjlDWjd2?=
 =?utf-8?B?SCtVSFA3NDNiMkRraFRNQmhQMlF4NTh6eTQyZ2d0TTAxYXNBTlpsTnRhTDM4?=
 =?utf-8?B?eEJPQnlmZzFIQTAwYS9qU2tLT0xBUVIxUzdGVnVZSFNXNElPb3puTzJIcUJr?=
 =?utf-8?B?S1JQRWtyRVBoRWFJOGtQZkRDdlRRUnhzUVpzL1ZnUitFSEV1a1pHdHIxKzZu?=
 =?utf-8?B?TjY2ZVNxQTNGQlg4QkRMakpVcW5ZMUIxQTg3ZGYzM21LNHIyS3hLbkgvRks1?=
 =?utf-8?B?T0U4aklpYTk1aHFrU2ExMWN2aUpieE9wUVU0dkxrMGZlZGFQTDRVZTN0aFcw?=
 =?utf-8?B?bWFiZXhXVEtOcmh4Smt0aG5wSGhRaHJndmJGdEJ1aDN0VnFhZ1JIZDZmV1Bj?=
 =?utf-8?B?MDMxazdiM0NpZlBadGp3am00MWxJNHNYMHNZWFFqcUdRbThHem94M0hrWW95?=
 =?utf-8?B?cUJBc25zNGlkeC9wcXVaYW10cHIxT1ZmS3A4TmxEZTRTazBaVEw0MFBvWm1Y?=
 =?utf-8?B?anhZbW5TanZmVjF5RHJwN2VhWitZbFdhd0MxSjJwTEZ0NXZHWkxtTEMzVjRH?=
 =?utf-8?B?L0dacEFRYjU4cjdTU1hJV1I1ZVpaZlVwbjlreVd1UFVyNnlaaHdudE4yQ3JN?=
 =?utf-8?B?ZDk3dndya04zbnF6MUg5bHlKTXZ4YVphYTk2RUV5Zll2Vmdza1hVdDNjUzlN?=
 =?utf-8?B?clRGSEZnY0pBakZtQXdoZFhYU0VJZmRENlVnczdBQ1k2eVFMYndaRTZrQXdN?=
 =?utf-8?B?QlNHcDZSdHNZOGdMZVlLTmlSVUh2OVNFSmVPblJDNE14RXp5N3BOeFRiSGFs?=
 =?utf-8?B?SzJJSHRyelVoamFYNDhLYms0MWdadVVCYnFUczZXOGJuem5XMVBudXd5Q1VF?=
 =?utf-8?B?M1h6WlQwZE9KWWhyMjl6dytZa0haMjB5OG9YYUF6eTdjdk4yMWhLVjFCKzZG?=
 =?utf-8?B?WERtSUZzZERFenA0QnlCbGNaQVN2Umx2ZnpXSEQ3YUd1bllja3BsNXVaOXhY?=
 =?utf-8?B?TWRNNnowOEVjMEhrUFh6V2F5S3VqNHNHQ2hyVUo3dWF3YVZuNWxSSjRDeXhQ?=
 =?utf-8?B?V3hhQVh6M043WHRtLzQ3Mkc5cjhhYm0velpzaDlCdnNOK0JRS2lFWUhkcHF6?=
 =?utf-8?B?Vk1oUWQvNzlHaktmTWc3c0ZVUEpUTkRSTWRhaUVVNWpCcWV6NU5lN2h5aVZx?=
 =?utf-8?B?V0lMN1VlajFtVURqQlZZMTNZcnpwdnFndXp6S0w2K1lGMU90UUVZVThIck56?=
 =?utf-8?B?U3VPbnBBT1ZLNmozajdwTWw4cXN1YXg4cmc4SW9MRks3dFhIWXd1WjBBODBi?=
 =?utf-8?B?MW1rV1FSYmE3NFdJQUlFajJTRU1hRk9TelJZWFhMS2QxSnJQTEZ2OWhBMW1u?=
 =?utf-8?B?V0VsNG9SdE1Bb0cxWnVwQmcrQ1FLZzNLdmhNdzRSbElWWVE0VjZzY2RMUU92?=
 =?utf-8?B?WEx6WTRJdVVsUXVhMWZLYlZ1SjZpMHo4bDlrZ3ZTY0QyUEk3RHBOdWEyZ05L?=
 =?utf-8?Q?ZrdIXRtSUOzHHUfG8j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f43bc3-33eb-4f9e-0fd8-08df3ea652a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 21:13:38.5393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0ryVjekH7qJ/2KU2DQW6tXH2oyvIymEsLpSGj3RyaGBQVE+ig2uH+gS2o/Itowk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------ktrWYMYoANa0X0wYJMxX0Mx0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-09 15:55, Han, Qiang wrote:
>
> AMD General
>
>
> Hi,
>
> I would like to have code review on this kfd fix.  I have an 
> observation: the buggy pageable GPU H2D copy read GPU machine code 
> from unrelated text from outside the container into the training input 
> tensor. These bytes have nothing to do with the intended data, and the 
> copy returned success with no error. This happens silently under host 
> memory pressure.
>
> The root cause should be a bug in the KFD kernel driver 
> (kfd_svm.c:svm_range_evict); a workaround and a tested kernel patch 
> are attached. kfd_svm_evict_fix_2026-11-08_v2.zip
>
> Philip has done the initial code review.
>
The patch is harder to review as an attachment — I'll resend it inline.

Regards,
Philip
>
> Thanks,
>
> Qiang
>

--------------ktrWYMYoANa0X0wYJMxX0Mx0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-09 15:55, Han, Qiang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CY8PR12MB7337BDE050C52DE73659883AE4732@CY8PR12MB7337.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        AMD General<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-family:DengXian">Hi, <o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-family:DengXian"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-family:DengXian">I
              would like to have code review on this kfd fix.&nbsp; I have an
              observation: the buggy pageable GPU H2D copy read GPU
              machine code from unrelated text from outside the
              container into the training input tensor. These bytes have
              nothing to do with the intended data, and the copy
              returned success with no error. This happens silently
              under host memory pressure.
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-family:DengXian"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-family:DengXian">The
              root cause should be a bug in the KFD kernel driver
              (kfd_svm.c:svm_range_evict); a workaround and a tested
              kernel patch are attached.
              kfd_svm_evict_fix_2026-11-08_v2.zip
              <o:p></o:p></span></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Philip has done the initial code review.</p>
        </div>
      </div>
    </blockquote>
    The patch is harder to review as an attachment — I'll resend it
    inline.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:CY8PR12MB7337BDE050C52DE73659883AE4732@CY8PR12MB7337.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Thanks,<o:p></o:p></p>
          <p class="MsoNormal">Qiang<o:p></o:p></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------ktrWYMYoANa0X0wYJMxX0Mx0--
