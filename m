From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC] Per file OOM badness
Date: Mon, 22 Jan 2018 20:59:19 -0500
Message-ID: <a2f42c82-4f37-1235-c16b-2bba48eafb6d@amd.com>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <20180122152315.749d88f3c91ffce4d70ac450@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0992958000=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180122152315.749d88f3c91ffce4d70ac450-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

This is a multi-part message in MIME format.
--===============0992958000==
Content-Type: multipart/alternative;
 boundary="------------6A6E3A4A1D18107554EA7ECB"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6A6E3A4A1D18107554EA7ECB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/22/2018 06:23 PM, Andrew Morton wrote:
> On Thu, 18 Jan 2018 11:47:48 -0500 Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org> wrote:
>
>> Hi, this series is a revised version of an RFC sent by Christian König
>> a few years ago. The original RFC can be found at
>> https://lists.freedesktop.org/archives/dri-devel/2015-September/089778.html
>>
>> This is the same idea and I've just adressed his concern from the original RFC
>> and switched to a callback into file_ops instead of a new member in struct file.
> Should be in address_space_operations, I suspect.  If an application
> opens a file twice, we only want to count it once?

Makes sense

>
> But we're putting the cart ahead of the horse here.  Please provide us
> with a detailed description of the problem which you are addressing so
> that the MM developers can better consider how to address your
> requirements.

I will just reiterate the problem statement from the original RFC, 
should have
put it in the body of the RFC and not just a link, as already commented 
by Michal.
Bellow is the quoted RFC.

Thanks,
Andrey

P.S You can also check the follow up discussion after this first email.

"

I'm currently working on the issue that when device drivers allocate memory on
behalf of an application the OOM killer usually doesn't knew about that unless
the application also get this memory mapped into their address space.

This is especially annoying for graphics drivers where a lot of the VRAM
usually isn't CPU accessible and so doesn't make sense to map into the
address space of the process using it.

The problem now is that when an application starts to use a lot of VRAM those
buffers objects sooner or later get swapped out to system memory, but when we
now run into an out of memory situation the OOM killer obviously doesn't knew
anything about that memory and so usually kills the wrong process

"




--------------6A6E3A4A1D18107554EA7ECB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 01/22/2018 06:23 PM, Andrew Morton
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20180122152315.749d88f3c91ffce4d70ac450-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org">
      <pre wrap="">On Thu, 18 Jan 2018 11:47:48 -0500 Andrey Grodzovsky <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="">Hi, this series is a revised version of an RFC sent by Christian König
a few years ago. The original RFC can be found at 
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/dri-devel/2015-September/089778.html">https://lists.freedesktop.org/archives/dri-devel/2015-September/089778.html</a>

This is the same idea and I've just adressed his concern from the original RFC 
and switched to a callback into file_ops instead of a new member in struct file.
</pre>
      </blockquote>
      <pre wrap="">
Should be in address_space_operations, I suspect.  If an application
opens a file twice, we only want to count it once?</pre>
    </blockquote>
    <br>
    Makes sense <br>
    <br>
    <blockquote type="cite"
      cite="mid:20180122152315.749d88f3c91ffce4d70ac450-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org">
      <pre wrap="">

But we're putting the cart ahead of the horse here.  Please provide us
with a detailed description of the problem which you are addressing so
that the MM developers can better consider how to address your
requirements.</pre>
    </blockquote>
    <br>
    I will just reiterate the problem statement from the original RFC,
    should have<br>
    put it in the body of the RFC and not just a link, as already
    commented by Michal.<br>
    Bellow is the quoted RFC.<br>
    <br>
    Thanks,<br>
    Andrey<br>
    <br>
    P.S You can also check the follow up discussion after this first
    email.<br>
    <br>
    "<br>
    <pre style="white-space: pre-wrap; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial;">I'm currently working on the issue that when device drivers allocate memory on
behalf of an application the OOM killer usually doesn't knew about that unless
the application also get this memory mapped into their address space.

This is especially annoying for graphics drivers where a lot of the VRAM
usually isn't CPU accessible and so doesn't make sense to map into the
address space of the process using it.

The problem now is that when an application starts to use a lot of VRAM those
buffers objects sooner or later get swapped out to system memory, but when we
now run into an out of memory situation the OOM killer obviously doesn't knew
anything about that memory and so usually kills the wrong process

"


</pre>
    <blockquote type="cite"
      cite="mid:20180122152315.749d88f3c91ffce4d70ac450-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org">
      <pre wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------6A6E3A4A1D18107554EA7ECB--

--===============0992958000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0992958000==--
