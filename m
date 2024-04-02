Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C48CD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 22:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B4910EEA9;
	Tue,  2 Apr 2024 22:33:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZYElcB8w";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2131.outbound.protection.outlook.com [40.107.101.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D2F10EEA9
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 22:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf+0Auio2Uh9V7+s4PWmKrg5xv88uUup9TNQ4quHS7Fi7+vNyOUJYDhJr69O8ei5DXpzPHxHXlMY84y++WUaQxEfbLxhJgHrovhto8hRtA1yO7p1M4HGLenpKT653RXOA9pLXpTyDuZfUUZN12Xz6ARJKj5jzRpXJ8l7m7YL2AQN5gsVspWh71/L6fD5mXBuSiwKC9Vm5+4P1ZNFTtNnw2yB1am9oYr19evyt2ODgLKoTR/UTVs1QGePG8IVLqx+SxoA3bL/U4g11cFIpn5R+qN6Hy83ZsLyDnB2kpsfcsFSPsP120ivdkw9cYn3vkzwZG7uIfAuDYZdm393iWTlpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADlzJfXvDifIXDJqc7tbgTAbCH2uKkX+uFQvyCzYvAk=;
 b=XOXGUnna7T/HuG8PVhY6AuP7C7quxmiFexLB5nZC/jfbGctnnNRxIB7y1bNXAUsLjttTpXKBL1Ps+ahA3tmUgIroiSjGY3qGeb0RgyU5zFDDY7uGlc42ITGNO8PKgVKPQmVnlYYsHdaOdtsZVFI4nUWi0d0h1hJyZRaE8Ued0QGhg0QpewlsCQvS6Gd2ctR95C35yjBYm4Rfu8LdEPJ3+6sEgNx6XkgkcwZZZmRZ+gKr5BzJOyZDvGf6tExDU5cJbfSkDZaz3FhrnnIaYdxhOpZqXslhG5N4WjGOkVHrto+IjrlnsuNw1uy7ZdqNB//zShN2SrJn+f5uRZotvQ36Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADlzJfXvDifIXDJqc7tbgTAbCH2uKkX+uFQvyCzYvAk=;
 b=ZYElcB8wws3Nz5xPfR901+WcmDg1cvaeqWruW9WiBuRkej452CIz+3imlIHWCj8ceWxcLWekklx5DbSESqvh0J02Hx+9Z+C1Z+bDqo5uREP9n/9cGjjGJR+lTKWzuoncMwLzAUmYhhjc3XsOhF+ur2eIdumjLsbBONfZQ269jZE=
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 22:32:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 22:32:59 +0000
Content-Type: multipart/alternative;
 boundary="------------OuYFUZh4427jMmtp0k14YJsE"
Message-ID: <c2a166e5-2fb1-4e57-ae37-a58e422b1a6f@amd.com>
Date: Tue, 2 Apr 2024 18:32:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amd/amdkfd: sync all devices to wait all processes
 being evicted
Content-Language: en-US
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Sashank.Saye@amd.com, Jeffrey.Chan@amd.com,
 philip.yang@amd.com, lijo.lazar@amd.com
References: <20240401215349.23361-1-Zhigang.Luo@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240401215349.23361-1-Zhigang.Luo@amd.com>
X-ClientProxiedBy: YQBPR0101CA0206.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB7350:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hn7YaFsMCrrX6DxO/WsJi1VeWamB9j/omCWE9xhcnU0k3qEDd9KoA91vdUnhSbR9cNAdVvPZfouoiqABygjATVqdP9K5Di9/86+s7SWDEChEJ5Tb/o3N9In9+T3Z0QC+nLvzrz7F3cnFeBEtkoGLuaScee8MhmZqULXKS5bfz+x18dcf0Ws9xuqHvbQkYeslYfCFJJf/xqEUM97mODA3HxXmKripOGHC6zeKbmyomGntj5nBKES/u6wKufWMydbyUaYveuYqYkO67VhwmrT00KC1434z7ryQxG14tkDb6bVxGY+vy74eFgeW9961Av0k8/DY0fVrSuoSKAJ0rLUg7+xz6MffDiNsKaxB5hBnZjbeOqKgozHDisxvEzTLxkgz9CdbXl7hLewC/bAJpOajApZiz4LZF4n48IPcXc1BUeZ/bvr/4LG3QhccJSTf3+QJ3beZEpDaDw0j9C/Md9gwgcvj0kWu9j74dPgBcXeV3Zab1f2ecA/0PUCRf4YtDM+nksPBzr+poOM46hL7DeMx7LWz3EoYhrsv/c6QXtEcziA06Kgmyw20iLKigX0wp8RLZv4ml8isTpmrqZhc8yofDqxun4+bW4wgyBRZ+2QfB9o5ZUT/+1q83qTTXCDH/9Pq8GeuYFl1j7btwuXHFMX+3QQA2NC0BXSK/ku/VC9qJ2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzQwNGNLK2l6eDFtSDZYNFlKR3BHZXpJTU9oNWNneEIzVWZlTTJHcVg3R3RV?=
 =?utf-8?B?OWVNNHJHdkJBek0xcWtyTHFCRzVwbEVpZWxlYUphRFRnZHBNWHJMOUxKcC9H?=
 =?utf-8?B?d2RmaFdjNWlYTVBON255Z1IzY2FFQU1zQmFEQnJFTHRaMGlJRHVYY3Q4TjFS?=
 =?utf-8?B?allUbWFWb2Z0S1FmYU9XVzgrN0ZVYXZLamFMTjJKY2J3RGREMEZiTFVmTmZV?=
 =?utf-8?B?Z0pjNkM0UmJ6bnJxdU44T1R0SUhXKzljdWRVOG5CTGRKUnE5a2dKNUpDbm1N?=
 =?utf-8?B?OFhHUTlKL0o5NW1HZTZ3K3ZmalVjMXRRMy9ISk9xRUg0ZldsUHk4cXNndUM0?=
 =?utf-8?B?Q0dsWFIwclNXUS9YcE1kMHNIdG5GQ0VPR081YzQ1R3g4MUFtUFJsTlhVa2JC?=
 =?utf-8?B?eDdOU2xUWm5CMTZlN0g5K0RUTmd1T0g0dHV4TnZYMU10NmI1S21pQVJwK3pI?=
 =?utf-8?B?SU16NThGbnI1bWJWMmxLRXZ3VkMrb0NYeW5UY3RCUjFIbGRjeVhUeENiV1Rt?=
 =?utf-8?B?V1hyelJDbnh5UUZRV0pYSkZyTGdTcEtMT0M1amVUeUJaNVdNWEpoVVh3a05o?=
 =?utf-8?B?b1pzejRZRUJsRzlONkF4bHhRZWVDREtPMTFUelNPcDFHdHl4bHRGVlpwNE43?=
 =?utf-8?B?MHMzRmpsT2F1WVVSWXR3Yld1Y040dGFTZU1yWHcrUExGNm9wdlRUbmlrUXR5?=
 =?utf-8?B?RnpxQnJET2JzUTYzKzdPa3dkd3ZYMFByMDZGa1F2Y1lpK1NRa2s0Z0tMak9w?=
 =?utf-8?B?eUo4aUd1UUgxWHA4anpEVkwrNlhtS0hMQkRER2RPQ25Jc215NXRQN0VuVDg3?=
 =?utf-8?B?cGlMTEZuZWY2UUlKOVdBYnVjQzJzb3VoWHVXV1c1Ym0wYjVSS005T2ZhZEIy?=
 =?utf-8?B?Q0VyZXVLT2dUQ0ROV0EzY3BzYmx0QmI3STgzNTBZb1RxbStkMmErSVd2Wisr?=
 =?utf-8?B?d3hHZmxBZ3BtMlBZK1pHMlpISXQ3TW9oU21acnQrdXZaZzM5c1MrNzZMMExW?=
 =?utf-8?B?dytwQXYrR0p1VWFSWkEyS1N5UDZtTjlKN3Rtd1JRTEkvTGduY28vUDFDWWYr?=
 =?utf-8?B?bEpTNjNRcHZrTHZNQ2VuSG1hTXFFUHp3NEJLVjJRWjAvTWJteTdINThLaGlX?=
 =?utf-8?B?ei9rdmJKWnVJMEc0NDg1Q0VCQ21pWGEyWU5Qa3VwSFBSb2FEdzFZRWRrRTJm?=
 =?utf-8?B?TXdtUTRtemRmcUcrWFBLc3ZmZkVGWFZTR3hPZkFrLzd0WmZ6L0FwNVJTNExr?=
 =?utf-8?B?MFlKR2NVVkt4eXhPcWRDNjh6RDdBTWwvR001QUpHQ2QxdkpaME5ucVVpZjZC?=
 =?utf-8?B?NkoxeE9oQjhaeHc2RnY3d3huL1hncHV0UmdhNW9aODY1MXdXblVuMGZNRFpW?=
 =?utf-8?B?TTZjeU8vVnpCcm1zeVpWOFR0YjhIeUJqbWNoY1NZQm91a1Roc1ZKdXFxUkdq?=
 =?utf-8?B?OGh0QUJQbGdtdlZzMjAxQ0ZoUkY5U2ZoSUFIUE1ucEFzVU5XSWhUbXBKRU5o?=
 =?utf-8?B?NElwNU9FSkgvcmpibmdvVEMzWlRIR0JBTWFTNWZIYXZsZGo4WXZvVGZnRms4?=
 =?utf-8?B?RXQ4SjBKa2ZQM0Y0YVpPK0FaNjhzWGM3VmlDcDZjQlZkU3htVkw0V1k4TC9q?=
 =?utf-8?B?WUFuWGdkdVp1T0UxbjlGbzl5aGlUcU1rNlVsL0lGSHJYRGtLZjE4ODNmSFYr?=
 =?utf-8?B?eTRUYkZ2VjU1c2tCRWhYRmtpM2NrNmNhV2JraTlCUUQ5REVaaSsxQy9kVGNx?=
 =?utf-8?B?R3U2dXB1WXZYQXN4YkExZ2VPNG5EUVBzUXpteDFvNlRFQVowR2J1Wm9wby9I?=
 =?utf-8?B?QTFUTkR4eFB6ZFhIRHJ3Y3VkaHVqNGVuVmRzajVrc2ZCU2gzYll3M29JeGxZ?=
 =?utf-8?B?WEFMWk50S2xxcGZ6aUlXUDNadDRwTTVVSWtXTW9rY1VBNUE5WGJGdnhtWGtm?=
 =?utf-8?B?dTNQN2F2dXZndDJZVmZYOWE0aEl0WjZxdHB4SnZrbDlyaERIclBlMlNGOXl3?=
 =?utf-8?B?czdmNHZ0TmcvME1rSDJCWWdyT0h2YmlHdkJPVTc4SjBqbisrQi85R2tMUnRn?=
 =?utf-8?B?bFVQUGttOUhBOUtYSU9WWkZmZFQydVJzbmI2bFhOR2VKMVdVSXFsckJWK1JM?=
 =?utf-8?Q?VVK699PrNfChapr1wQyErW7GI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4034d8a9-7396-4d92-9f6a-08dc5364d93f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:32:58.8699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lb7gUZOvAbdRhVsZlw+FrnQWmPHaDdkUDPKKzDllVTgFHrjjydg+NUUufA5hn5j/qxF7KuLBC4KNJxWxFXydUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------OuYFUZh4427jMmtp0k14YJsE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-04-01 17:53, Zhigang Luo wrote:
> If there are more than one device doing reset in parallel, the first
> device will call kfd_suspend_all_processes() to evict all processes
> on all devices, this call takes time to finish. other device will
> start reset and recover without waiting. if the process has not been
> evicted before doing recover, it will be restored, then caused page
> fault.
>
> Signed-off-by: Zhigang Luo<Zhigang.Luo@amd.com>
> Change-Id: Ib1eddb56b69ecd41fe703abd169944154f48b0cd

Please remove the Change-Id: before you push. Other than that, this patch is


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 041ec3de55e7..55f89c858c7a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -969,11 +969,11 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>   	if (!run_pm) {
>   		mutex_lock(&kfd_processes_mutex);
>   		count = ++kfd_locked;
> -		mutex_unlock(&kfd_processes_mutex);
>   
>   		/* For first KFD device suspend all the KFD processes */
>   		if (count == 1)
>   			kfd_suspend_all_processes();

This could be simplified now. The variable "count" was only needed for 
the broken attempt to do call suspend outside the lock. Now you can just do:

	mutex_lock(&kfd_processes_mutex);
	if (++kfd_locked == 1)
		kfd_suspend_all_processes();
	mutex_unlock(&kfd_processes_mutex);

To be consistent, we probably need to make a similar change in 
kgd2kfd_resume and run kfd_resume_all_processes under the lock as well. 
Otherwise there could be a race condition between suspend and resume.

Regards,
   Felix


> +		mutex_unlock(&kfd_processes_mutex);
>   	}
>   
>   	for (i = 0; i < kfd->num_nodes; i++) {
--------------OuYFUZh4427jMmtp0k14YJsE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2024-04-01 17:53, Zhigang Luo wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240401215349.23361-1-Zhigang.Luo@amd.com">
      <pre class="moz-quote-pre" wrap="">If there are more than one device doing reset in parallel, the first
device will call kfd_suspend_all_processes() to evict all processes
on all devices, this call takes time to finish. other device will
start reset and recover without waiting. if the process has not been
evicted before doing recover, it will be restored, then caused page
fault.

Signed-off-by: Zhigang Luo <a class="moz-txt-link-rfc2396E" href="mailto:Zhigang.Luo@amd.com">&lt;Zhigang.Luo@amd.com&gt;</a>
Change-Id: Ib1eddb56b69ecd41fe703abd169944154f48b0cd</pre>
    </blockquote>
    <p>Please remove the Change-Id: before you push. Other than that,
      this patch is</p>
    <br>
    <blockquote type="cite" cite="mid:20240401215349.23361-1-Zhigang.Luo@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 041ec3de55e7..55f89c858c7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -969,11 +969,11 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 	if (!run_pm) {
 		mutex_lock(&amp;kfd_processes_mutex);
 		count = ++kfd_locked;
-		mutex_unlock(&amp;kfd_processes_mutex);
 
 		/* For first KFD device suspend all the KFD processes */
 		if (count == 1)
 			kfd_suspend_all_processes();</pre>
    </blockquote>
    <p>This could be simplified now. The variable &quot;count&quot; was only
      needed for the broken attempt to do call suspend outside the lock.
      Now you can just do:</p>
    <pre>	mutex_lock(&amp;kfd_processes_mutex);
	if (++kfd_locked == 1)
		kfd_suspend_all_processes();
	mutex_unlock(&amp;kfd_processes_mutex);
</pre>
    <p>To be consistent, we probably need to make a similar change in
      kgd2kfd_resume and run kfd_resume_all_processes under the lock as
      well. Otherwise there could be a race condition between suspend
      and resume.<br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20240401215349.23361-1-Zhigang.Luo@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		mutex_unlock(&amp;kfd_processes_mutex);
 	}
 
 	for (i = 0; i &lt; kfd-&gt;num_nodes; i++) {
</pre>
    </blockquote>
  </body>
</html>

--------------OuYFUZh4427jMmtp0k14YJsE--
